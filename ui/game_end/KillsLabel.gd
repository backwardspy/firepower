extends Label

func _ready():
    text = "You killed %s drones" % ScoreTracker.get_mobs_killed()
