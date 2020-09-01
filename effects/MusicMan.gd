extends Node

export var fade_duration := 5.0

const silent := -80.0

onready var _battle_music: AudioStreamPlayer = $BattleMusicPlayer
onready var _idle_music: AudioStreamPlayer = $IdleMusicPlayer
onready var _tween: Tween = $Tween
onready var _normal_battle_vol := _battle_music.volume_db
onready var _normal_idle_vol := _idle_music.volume_db

func _fade(from: AudioStreamPlayer, to: AudioStreamPlayer):
    to.volume_db = silent
    from.volume_db = _normal_idle_vol
    to.play()
    _tween.interpolate_property(
        to,
        "volume_db",
        silent,
        _normal_battle_vol,
        fade_duration,
        Tween.TRANS_EXPO,
        Tween.EASE_OUT
    )
    _tween.interpolate_property(
        from,
        "volume_db",
        _normal_idle_vol,
        silent,
        fade_duration,
        Tween.TRANS_EXPO,
        Tween.EASE_IN
    )
    _tween.start()
    yield(_tween, "tween_all_completed")
    from.stop()

# unused arg lets us accept signals with either 0 or 1 arguments
# it'd be nice if i could just discard signal arguments somehow
func to_battle(_unused = 0):
    _fade(_idle_music, _battle_music)

func to_idle(_unused = 0):
    _fade(_battle_music, _idle_music)

func _process(dt: float):
    print(_battle_music.volume_db, " ", _idle_music.volume_db)
