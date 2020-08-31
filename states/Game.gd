extends Node2D

func handle_player_death():
    get_tree().change_scene("res://states/GameOver.tscn")

func _ready():
    randomize()

func _on_Player_died():
    call_deferred("handle_player_death")
