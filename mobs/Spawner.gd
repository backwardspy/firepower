extends Node

export var player_path: NodePath
export var mob_scene: PackedScene

onready var _spawn_points := get_children()
onready var _player := get_node(player_path)

func spawn():
    var spawn_point: Position2D = _spawn_points[randi() % _spawn_points.size()]
    var mob: Mob = mob_scene.instance()
    mob.set_player(_player)
    mob.position = spawn_point.position
    get_tree().current_scene.add_child(mob)
