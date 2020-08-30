extends Area2D

class_name Bullet

export var speed := 600.0
export var damage := 10.0
export var break_on_hit := true

var _direction: Vector2

func fire(direction: Vector2):
    _direction = direction.normalized()

func _process(dt: float):
    translate(_direction * speed * dt)

func _on_Bullet_body_entered(body: Node):
    var is_mob: bool = body.is_in_group("mobs")
    if is_mob:
        (body as Mob).hurt(damage, _direction)

    # break_on_hit only applies to mob collisions
    # everything else breaks regardless
    if break_on_hit or not is_mob:
        queue_free()
