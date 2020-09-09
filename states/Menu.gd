extends Control

func start_game():
    Transit.change_scene("res://states/Game.tscn", 1.0)

func about():
    Transit.change_scene("res://states/About.tscn")

func quit_game():
    get_tree().quit()
