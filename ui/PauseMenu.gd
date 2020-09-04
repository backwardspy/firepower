extends Control

signal resume_pressed
signal quit_pressed

func resume():
    emit_signal("resume_pressed")

func quit():
    $QuitConfirm.visible = true

func confirm_quit():
    $QuitConfirm.visible = false
    emit_signal("quit_pressed")

func cancel_quit():
    $QuitConfirm.visible = false
