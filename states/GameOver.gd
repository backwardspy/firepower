extends Control

onready var _tween: Tween = $Tween

func _fade_to_scene(path: String):
    focus_mode = Control.FOCUS_NONE

    $Blackout.visible = true

    var _r := _tween.interpolate_property(
        $Blackout,
        "color:a",
        0,
        1,
        0.5,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
    )

    _r = _tween.start()
    yield(_tween, "tween_all_completed")
    var err := get_tree().change_scene(path)
    if err:
        push_error("failed to change scene to %s: %s" % [path, err])

func retry():
    _fade_to_scene("res://states/Game.tscn")

func menu():
    _fade_to_scene("res://states/Menu.tscn")

func _ready():
    var scores: ScoreTracker = get_node("/root/ScoreTracker")
    $ControlsBox/ScrapEarned.text = "You earned %s Scrap" % scores.get_scrap_earned()
    $ControlsBox/MobsKilled.text = "You killed %s drones" % scores.get_mobs_killed()
