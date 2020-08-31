extends Control

func start_game():
    get_tree().change_scene("res://states/Game.tscn")

func quit_game():
    get_tree().quit()
