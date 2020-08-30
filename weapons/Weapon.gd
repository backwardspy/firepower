extends Node2D

export var bullet_scene: PackedScene
export var time_between_shots := 0.2

onready var _timer := $FireTimer

func fire():
    $AudioPlayer.play()
    var bullet: Bullet = bullet_scene.instance()
    bullet.position = $MuzzlePoint.global_position
    bullet.fire(global_transform.x)
    get_tree().root.add_child(bullet)
    _timer.start(time_between_shots)

func _process(_dt: float):
    if Input.is_action_pressed("shoot") and _timer.time_left == 0:
        fire()

func _ready():
    if bullet_scene == null:
        push_error("no bullet has been assigned to weapon %s" % self.name)
