extends StaticBody2D

class_name Scrap

onready var tween := $Tween

const _frames = [56, 57, 94, 95]

var _succable := true

func _fly_away(player: Node2D):
    $CollisionShape2D.disabled = true

    tween.interpolate_property(
        self,
        "global_position",
        global_position,
        player.global_position,
        0.2,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
    )
    tween.start()
    yield(tween, "tween_all_completed")
    queue_free()

func succ(player: Node2D):
    if not _succable:
        return

    _succable = false
    $DespawnTimer.stop()
    call_deferred("_fly_away", player)

func _ready():
    $Sprite.frame = _frames[randi() % _frames.size()]
    $Shadow.frame = $Sprite.frame
