extends Node

onready var _pause_menu: Control = $"../UI/Control/PauseMenu"

func unpause():
    _pause_menu.visible = false
    get_tree().paused = false

func pause():
    get_tree().paused = true
    _pause_menu.visible = true

func quit():
    unpause()
    $"..".quit_to("res://states/Menu.tscn")

func _input(event: InputEvent):
    if event.is_action_pressed("ui_cancel"):
        if _pause_menu.visible:
            unpause()
        else:
            pause()
