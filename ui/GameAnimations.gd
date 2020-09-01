extends AnimationPlayer

export var wave_start_label: NodePath
export var wave_start_label_shadow: NodePath

onready var _wave_start_label: Label = get_node(wave_start_label)
onready var _wave_start_label_shadow: Label = get_node(wave_start_label_shadow)

func _on_Spawner_wave_started(difficulty: int):
    var label_text := "Wave %s" % difficulty
    _wave_start_label.text = label_text
    _wave_start_label_shadow.text = label_text
    play("wave-start")
