extends Control

func _on_RichTextLabel_meta_clicked(meta: String):
    OS.shell_open(meta)

func _on_MenuButton_pressed():
    Transit.change_scene("res://states/Menu.tscn", 1.0)
