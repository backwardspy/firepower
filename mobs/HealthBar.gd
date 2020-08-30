extends TextureProgress

onready var tween := $Tween

func _ready():
    visible = false

func _on_Mob_health_changed(percentage: float):
    visible = 1 > percentage and percentage > 0

    tween.interpolate_property(
        self,
        "value",
        value,
        int(percentage * 100),
        0.1,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
    )
    tween.start()
