extends Area2D

class_name MobBullet

export var speed := 200.0
export var damage := 10.0

var _direction: Vector2

func fire(direction: Vector2):
    _direction = direction.normalized()

func _process(dt: float):
    translate(_direction * speed * dt)

func _on_MobBullet_body_entered(body):
    var is_player: bool = body.is_in_group("player")
    if is_player:
        body.hurt(damage)

    queue_free()
