extends Control

func retry():
    Transit.change_scene("res://states/Game.tscn", 1.0)

func menu():
    Transit.change_scene("res://states/Menu.tscn", 1.0)

func _ready():
    $ControlsBox/ScrapEarned.text = "You earned %s Scrap" % ScoreTracker.get_scrap_earned()
    $ControlsBox/MobsKilled.text = "You killed %s drones" % ScoreTracker.get_mobs_killed()
    $ControlsBox/Score.text = "Score: %s" % ScoreTracker.calculate_score()
