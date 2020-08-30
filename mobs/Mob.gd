extends KinematicBody2D

class_name Mob

signal health_changed

export var bounds := Rect2(-220, -220, 220, 220)
export var speed := 300.0
export var max_health := 100.0
export var shoot_range := 200.0
export var bullet_scene: PackedScene

onready var _invuln_timer := $InvulnTimer
onready var _health := max_health

var _targetPos := Vector2.ZERO
var _vel := Vector2.ZERO
var _player: Node2D = null
var _invuln := false
var _exploding := false

func set_player(player: Node2D):
    _player = player

func hurt(damage: float, direction: Vector2):
    if _invuln or _exploding:
        return

    _vel += direction * 20.0

    $DamageNumberSpawner.fire(int(damage))

    _health -= damage
    if _health <= 0:
        _die()
    else:
        $Sprite.modulate = Color(2.0, 0.8, 0.8)
        _invuln = true
        $InvulnTimer.start()

    emit_signal("health_changed", _health / max_health)

func _die():
    _health = 0
    _exploding = true
    $ShootTimer.stop()
    $AnimationPlayer.play("explode")
    $AudioStreamPlayer.play()
    yield($AudioStreamPlayer, "finished")
    queue_free()

func _pick_new_target():
    _targetPos = Vector2(
        rand_range(bounds.position.x, bounds.size.x),
        rand_range(bounds.position.y, bounds.size.y)
    )

func _process(dt: float):
    if _exploding:
        _vel = move_and_slide(_vel)
        return

    var diff := _targetPos - global_position
    while diff.length_squared() <= 500.0:
        _pick_new_target()
        diff = _targetPos - global_position

    var accel := diff.normalized() * speed
    _vel = (_vel + accel * dt).clamped(speed)
    _vel = move_and_slide(_vel)
    if get_slide_count():
        _pick_new_target()

    $Sprite.rotation = atan2(_vel.y, _vel.x)
    $Shadow.rotation = $Sprite.rotation

func _ready():
    _pick_new_target()

func _on_ShootTimer_timeout():
    var to_player := _player.global_position - global_position
    if to_player.length_squared() > shoot_range * shoot_range:
        return

    var bullet: MobBullet = bullet_scene.instance()
    bullet.position = global_position + to_player.normalized() * 16
    bullet.fire(to_player)
    get_tree().root.add_child(bullet)

func _on_InvulnTimer_timeout():
    $Sprite.modulate = Color.white
    _invuln = false
