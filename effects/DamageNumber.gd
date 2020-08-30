extends Label

class_name DamageNumber

func fire(damage: int, travel: Vector2, duration: float, spread: float):
    text = str(damage)
    var movement := travel.rotated(rand_range(-spread, spread))
    rect_pivot_offset = rect_size / 2

    var tween := $Tween

    tween.interpolate_property(
        self,
        "rect_position",
        rect_position,
        rect_position + movement,
        duration,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN_OUT
    )

    tween.interpolate_property(
        self,
        "modulate:a",
        1.0,
        0.0,
        duration,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN_OUT
    )

    tween.start()
    yield(tween, "tween_all_completed")
    queue_free()
