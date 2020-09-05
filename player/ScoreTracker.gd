extends Node

var _scrap_earned := 0
var _mobs_killed := 0

func add_scrap_earned(amount: int):
    _scrap_earned += amount

func add_mob_kill():
    _mobs_killed += 1

func get_scrap_earned() -> int:
    return _scrap_earned

func get_mobs_killed() -> int:
    return _mobs_killed

func calculate_score() -> int:
    return _scrap_earned + _mobs_killed * 10

func reset():
    _scrap_earned = 0
    _mobs_killed = 0
