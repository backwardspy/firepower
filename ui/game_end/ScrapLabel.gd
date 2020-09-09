extends Label

func _ready():
    text = "You earned %s Scrap" % ScoreTracker.get_scrap_earned()
