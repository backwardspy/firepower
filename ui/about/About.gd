extends Control

func back_to_menu():
    get_tree().change_scene("res://states/Menu.tscn")

func _on_AboutInfo_meta_clicked(meta):
    OS.shell_open(meta)
