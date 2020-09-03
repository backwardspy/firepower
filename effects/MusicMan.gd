extends Node

export var fade_duration := 5.0

const silent := -80.0

onready var _battle_music: AudioStreamPlayer = $BattleMusicPlayer
onready var _idle_music: AudioStreamPlayer = $IdleMusicPlayer
onready var _tween: Tween = $Tween
onready var _normal_battle_vol := _battle_music.volume_db
onready var _normal_idle_vol := _idle_music.volume_db

func _fade(from: AudioStreamPlayer, to: AudioStreamPlayer, fade_out_mode: bool = false):
    var _b := _tween.stop_all()
    to.volume_db = silent
    from.volume_db = _normal_idle_vol
    to.play()
    _b = _tween.interpolate_property(
        to,
        "volume_db",
        null if fade_out_mode else silent,
        silent if fade_out_mode else _normal_battle_vol,
        1.0 if fade_out_mode else fade_duration,
        Tween.TRANS_EXPO,
        Tween.EASE_OUT
    )
    _b = _tween.interpolate_property(
        from,
        "volume_db",
        null if fade_out_mode else _normal_idle_vol,
        silent,
        1.0 if fade_out_mode else fade_duration,
        Tween.TRANS_EXPO,
        Tween.EASE_OUT if fade_out_mode else Tween.EASE_IN
    )
    _b = _tween.start()
    yield(_tween, "tween_all_completed")
    from.stop()

func fade_out():
    _fade(_idle_music, _battle_music, true)

# unused arg lets us accept signals with either 0 or 1 arguments
# it'd be nice if i could just discard signal arguments somehow
func to_battle(_unused = 0):
    _fade(_idle_music, _battle_music)

func to_idle(_unused = 0):
    _fade(_battle_music, _idle_music)
