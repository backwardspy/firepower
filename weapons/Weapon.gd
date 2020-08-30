extends Node2D

export var bullet: PackedScene
export var time_between_shots := 0.2

func fire():
    var _bullet: Bullet = bullet.instance()
    _bullet.position = $MuzzlePoint.global_position
    _bullet.fire(global_transform.x)
    get_tree().root.add_child(_bullet)

func _ready():
    if bullet == null:
        push_error("no bullet has been assigned to weapon %s" % self.name)
    $FireTimer.start(time_between_shots)

func _on_FireTimer_timeout():
    if Input.is_action_pressed("shoot"):
        fire()
