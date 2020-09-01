extends Control

signal upgrade_purchased
signal wave_repeated

func _on_TEMPNextWave_pressed():
    emit_signal("upgrade_purchased")

func _on_Repeat_pressed():
    emit_signal("wave_repeated")
