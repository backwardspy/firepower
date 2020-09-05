extends Label

onready var _score: ScoreTracker = get_node("/root/ScoreTracker")

func _ready():
    text = "Score: %s" % _score.calculate_score()
