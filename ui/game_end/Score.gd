extends Label

func _ready():
    text = "Score: %s" % ScoreTracker.calculate_score()
