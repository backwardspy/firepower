extends Control

onready var _tween: Tween = $Tween
onready var _blackout: ColorRect = $Blackout

func _on_RichTextLabel_meta_clicked(meta: String):
    OS.shell_open(meta)

func _on_MenuButton_pressed():
    focus_mode = Control.FOCUS_NONE
    _blackout.visible = true
    _tween.interpolate_property(
        _blackout,
        "color:a",
        0,
        1,
        3,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN
    )
    _tween.start()
    yield(_tween, "tween_all_completed")

    var err := get_tree().change_scene("res://states/Menu.tscn")
    if err:
        push_error("failed to change to menu scene: %s" % err)
