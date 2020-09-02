extends Node2D

func handle_player_death():
    var err := get_tree().change_scene("res://states/GameOver.tscn")
    if err:
        push_error("failed to change to game over scene: %s" % err)

func _ready():
    randomize()

func _on_Player_died():
    call_deferred("handle_player_death")
