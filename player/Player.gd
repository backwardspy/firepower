extends KinematicBody2D

export var MOVE_SPEED := 100.0

var _vel := Vector2.ZERO

func damp(a: Vector2, b: Vector2, lambda: float, dt: float) -> Vector2:
    return lerp(a, b, 1 - exp(-lambda * dt))

func _move(dt: float):
    var move := Vector2(
        int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
        int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
    ).normalized() * MOVE_SPEED

    _vel = damp(_vel, move, 10.0, dt)
    _vel = move_and_slide(_vel)

    var to_mouse := get_global_mouse_position() - global_position
    $Hub.rotation = atan2(to_mouse.y, to_mouse.x)
    $Shadow.rotation = $Hub.rotation

func _process(dt: float):
    _move(dt)
