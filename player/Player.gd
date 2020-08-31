extends KinematicBody2D

class_name Player

signal health_changed
signal scrap_changed
signal died

export var move_speed := 100.0
export var max_health := 500.0

var _vel := Vector2.ZERO
var _scrap := 0

onready var _health := max_health

func hurt(damage: float):
    _health -= damage
    if _health <= 0.0:
        _health = 0.0
        emit_signal("died")

    emit_signal("health_changed", _health / max_health)

func _add_scrap():
    _scrap += 1

    emit_signal("scrap_changed", _scrap)

func _damp(a: Vector2, b: Vector2, lambda: float, dt: float) -> Vector2:
    return lerp(a, b, 1 - exp(-lambda * dt))

func _move(dt: float):
    var move := Vector2(
        int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
        int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
    ).normalized() * move_speed

    _vel = _damp(_vel, move, 10.0, dt)
    _vel = move_and_slide(_vel)

    var to_mouse := get_global_mouse_position() - global_position
    $Hub.rotation = atan2(to_mouse.y, to_mouse.x)
    $Shadow.rotation = $Hub.rotation

func _process(dt: float):
    _move(dt)

func _on_LootSuccArea_body_entered(body):
    if body is Scrap:
        body.succ(self)
        _add_scrap()
