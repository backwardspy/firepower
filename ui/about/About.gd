extends Control

func back_to_menu():
    Transit.change_scene("res://states/Menu.tscn")

func _on_AboutInfo_meta_clicked(meta):
    var err := OS.shell_open(meta)
    if err:
        push_error("Failed to open %s: %s" % [meta, err])
