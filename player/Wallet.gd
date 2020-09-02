extends Node

signal scrap_changed

var _scrap := 0

func add_scrap(amount: int):
    _scrap += amount
    emit_signal("scrap_changed", _scrap)

func try_remove_scrap(amount: int) -> bool:
    if amount > _scrap:
        return false
    _scrap -= amount
    emit_signal("scrap_changed", _scrap)
    return true

func has_enough_for(amount: int) -> bool:
    return _scrap >= amount

func get_balance() -> int:
    return _scrap
