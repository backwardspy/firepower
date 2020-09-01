extends ColorRect

onready var _tween = $Tween

func _ready():
    _tween.interpolate_property(
        self,
        "color:a",
        1,
        0,
        0.5,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
    )
    _tween.start()
    yield(_tween, "tween_all_completed")
    queue_free()
