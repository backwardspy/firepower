extends Node2D

onready var _score_tracker: ScoreTracker = get_node("/root/ScoreTracker")
onready var _blackout: ColorRect = $UI/Blackout
onready var _tween: Tween = $Tween

var _in_endless_wave := false

func handle_player_death():
    $MusicMan.fade_out()

    _blackout.visible = true
    var _r := _tween.interpolate_property(
        _blackout,
        "color:a",
        0,
        1,
        3,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN
    )
    _r = _tween.start()
    yield(_tween, "tween_all_completed")

    var scene := "res://states/GameEnd.tscn" if _in_endless_wave else "res://states/GameOver.tscn"
    var err := get_tree().change_scene(scene)
    if err:
        push_error("failed to change to %s scene: %s" % [scene, err])

func _ready():
    randomize()
    get_node("/root/Wallet").empty()

func _on_Player_died():
    call_deferred("handle_player_death")

func _on_Spawner_wave_started(difficulty: int):
    if difficulty < 0:
        _in_endless_wave = true
