extends Label

onready var _score: ScoreTracker = get_node("/root/ScoreTracker")

func _ready():
    text = "You killed %s drones" % _score.get_mobs_killed()
