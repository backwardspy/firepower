extends Node2D

class_name Weapon

export var bullet_scene: PackedScene
export var time_between_shots := 0.2
export var reduces_volume_on_add := false

onready var _timer := $FireTimer

func reduce_volume(times: int = 1):
    $AudioPlayer.volume_db -= 3.0 * times

func fire():
    $AudioPlayer.play()
    var bullet: Bullet = bullet_scene.instance()
    bullet.position = $MuzzlePoint.global_position
    bullet.fire(global_transform.x)
    get_tree().current_scene.add_child(bullet)
    _timer.start(time_between_shots)

func _process(_dt: float):
    if Input.is_action_pressed("shoot") and _timer.time_left == 0:
        fire()

func _ready():
    if bullet_scene == null:
        push_error("no bullet has been assigned to weapon %s" % self.name)
