extends Node2D

var _damage_number_scene := preload("res://effects/DamageNumber.tscn")

export var travel := Vector2(0, -80)
export var duration := 2.0
export var spread := PI / 2.0

func fire(damage: int):
    var damage_number: DamageNumber = _damage_number_scene.instance()
    add_child(damage_number)
    damage_number.fire(damage, travel, duration, spread)
