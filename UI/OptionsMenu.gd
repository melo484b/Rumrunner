extends CanvasLayer


signal back_pressed


func _on_WindowedButton_pressed():
	OS.window_fullscreen = false


func _on_FullButton_pressed():
	OS.window_fullscreen = true


func _on_MainMenu_pressed():
	emit_signal("back_pressed")
