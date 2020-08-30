extends KinematicBody2D

class_name MobBullet

export var speed := 200.0
export var damage := 10.0

var _direction: Vector2

func fire(direction: Vector2):
    _direction = direction.normalized()

func _process(dt: float):
    var coll := move_and_collide(_direction * speed * dt)
    if coll:
        queue_free()
