extends KinematicBody2D

class_name Mob

signal health_changed
signal died

export var bounds := Rect2(-220, -220, 220, 220)
export var speed := 300.0
export var max_health := 100.0
export var max_loot_drop := 20
export var shoot_range := 200.0
export var bullet_scene: PackedScene
export var scrap_scene: PackedScene

onready var _invuln_timer := $InvulnTimer
onready var _health := max_health

onready var _modulate = $Sprite.modulate

const HURT_MODULATE = Color(8.0, 3.2, 3.2)

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

    _vel += direction * 100.0

    $DamageNumberSpawner.fire(int(damage))

    _health -= damage
    if _health <= 0:
        _die()
    else:
        $Sprite.modulate = HURT_MODULATE
        _invuln = true
        $InvulnTimer.start()

    emit_signal("health_changed", _health / max_health)

func _spawn_loot():
    var loot_amount := randi() % max_loot_drop
    for i in loot_amount:
        var scrap: StaticBody2D = scrap_scene.instance()
        var dir := Vector2.RIGHT.rotated(rand_range(0, 2 * PI)) * rand_range(1, 50)
        scrap.position = global_position + dir
        get_tree().current_scene.add_child(scrap)

func _die():
    _health = 0
    _exploding = true

    $ShootTimer.stop()
    $AnimationPlayer.play("explode")
    $AudioStreamPlayer.play()
    $CollisionShape2D.disabled = true

    call_deferred("_spawn_loot")

    emit_signal("died")

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
    get_tree().current_scene.add_child(bullet)

func _on_InvulnTimer_timeout():
    $Sprite.modulate = _modulate
    _invuln = false
