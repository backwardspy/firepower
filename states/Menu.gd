extends Control

onready var _tween := $Tween

func start_game():
    focus_mode = Control.FOCUS_NONE

    $Blackout.visible = true

    _tween.interpolate_property(
        $Blackout,
        "color:a",
        0,
        1,
        0.5,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
    )

    _tween.interpolate_property(
        $AudioStreamPlayer,
        "volume_db",
        0,
        -80,
        0.5,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN
    )

    _tween.start()
    yield(_tween, "tween_all_completed")
    get_tree().change_scene("res://states/Game.tscn")

func quit_game():
    get_tree().quit()
