extends Node

signal wave_ended
signal wave_started

export var base_mobs_per_wave := 5
export var mobs_per_difficulty := 2.0
export var mobs_per_difficulty_exp := 1.25
export var min_spawn_per_second := 0.5
export var max_spawn_per_second := 2.0
export var spawn_rate_per_wave := 0.1
export var player_path: NodePath
export var upgrade_shop_path: NodePath
export var mob_scene: PackedScene

onready var _spawn_points := get_children()
onready var _player := get_node(player_path)
onready var _upgrade_shop: CanvasItem = get_node(upgrade_shop_path)
onready var _spawn_timer: Timer = get_node("../SpawnTimer")

var _wave_difficulty := 1

var _max_mobs := 0
var _spawn_per_second := 0.5

var _spawned_this_wave := 0
var _died_this_wave := 0

func _calc_max_mobs():
    return (
        base_mobs_per_wave +
        int((_wave_difficulty - 1) * mobs_per_difficulty) +
        int(pow(mobs_per_difficulty_exp, _wave_difficulty) - 1)
    )

func _new_wave(difficulty: int):
    emit_signal("wave_started", _wave_difficulty)

    _wave_difficulty = difficulty
    _spawn_per_second = lerp(
        min_spawn_per_second,
        max_spawn_per_second,
        min((_wave_difficulty - 1) * spawn_rate_per_wave, 1)
    )
    _max_mobs = _calc_max_mobs()

    print("starting wave of difficulty %s with %s mobs and %s spawns/s" % [_wave_difficulty, _max_mobs, _spawn_per_second])

    _spawned_this_wave = 0
    _died_this_wave = 0

    _spawn_timer.start(1.0 / _spawn_per_second)

func _end_wave():
    emit_signal("wave_ended")

    _upgrade_shop.visible = true

func _on_mob_death():
    _died_this_wave += 1

    if _died_this_wave >= _max_mobs:
        _end_wave()

func spawn():
    if _spawned_this_wave >= _max_mobs:
        return

    var spawn_point: Position2D = _spawn_points[randi() % _spawn_points.size()]
    var mob: Mob = mob_scene.instance()
    mob.set_player(_player)
    mob.position = spawn_point.position

    mob.connect("died", self, "_on_mob_death")

    get_tree().current_scene.add_child(mob)

    _spawned_this_wave += 1

func _ready():
    _new_wave(1)

func _on_UpgradeShop_upgrade_purchased():
    _upgrade_shop.visible = false
    _new_wave(_wave_difficulty + 1)

func _on_UpgradeShop_wave_repeated():
    _upgrade_shop.visible = false
    _new_wave(_wave_difficulty)
