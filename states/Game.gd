extends Node2D

var _in_endless_wave := false

func handle_player_death():
    var scene := "res://states/GameEnd.tscn" if _in_endless_wave else "res://states/GameOver.tscn"
    quit_to(scene)

func quit_to(scene: String):
    $MusicMan.fade_out()
    Transit.change_scene(scene, 1.0)

func _ready():
    randomize()
    Wallet.empty()

func _on_Player_died():
    call_deferred("handle_player_death")

func _on_Spawner_wave_started(difficulty: int):
    if difficulty < 0:
        _in_endless_wave = true
