extends Label

onready var _score: ScoreTracker = get_node("/root/ScoreTracker")

func _ready():
    text = "You earned %s Scrap" % _score.get_scrap_earned()
