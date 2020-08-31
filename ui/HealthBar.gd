extends TextureProgress

onready var tween := $Tween

func _on_Player_health_changed(percentage: float):
    tween.interpolate_property(
        self,
        "value",
        value,
        int(percentage * 100),
        0.5,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
    )
    tween.start()
