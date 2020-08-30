extends KinematicBody2D

class_name Bullet

export var speed := 600.0
export var damage := 10.0
export var break_on_hit := true

var _direction: Vector2

func fire(direction: Vector2):
    _direction = direction.normalized()

func _process(dt: float):
    var coll := move_and_collide(_direction * speed * dt)
    if coll is KinematicCollision2D and coll.collider is Node:
        var is_mob: bool = coll.collider.is_in_group("mobs")
        if is_mob:
            (coll.collider as Mob).hurt(damage, _direction)

        # break_on_hit only applies to mob collisions
        # everything else breaks regardless
        if break_on_hit or not is_mob:
            queue_free()
