extends HBoxContainer

onready var letters := get_children()

func _process(_delta: float):
    var t := OS.get_system_time_msecs() / 1000.0
    for i in get_child_count():
        var letter: TextureRect = letters[i]
        letter.rect_position.y = -abs(sin(t - i * 0.2)) * 12.0
