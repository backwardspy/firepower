extends Node

export var initial_bonus := 30

onready var _label: Label = $"../UI/Control/ScrapBonusBox/BonusLabel"
onready var _timer: Timer = $Timer

var _bonus := 0

func _update_label():
    _label.text = "Bonus: +%s" % _bonus

func _on_Timer_timeout():
    if _bonus > 0:
        _bonus -= 1
        _update_label()

func _on_Spawner_wave_started(difficulty: int):
    if difficulty < 0:
        # no more bonuses in endless wave
        queue_free()

    _bonus = initial_bonus
    _update_label()
    _timer.start()

func _on_Spawner_wave_ended():
    _timer.stop()
    if _bonus > 0:
        Wallet.add_scrap(_bonus)
