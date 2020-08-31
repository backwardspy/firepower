extends Control

func retry():
    get_tree().change_scene("res://states/Game.tscn")

func menu():
    get_tree().change_scene("res://states/Menu.tscn")
