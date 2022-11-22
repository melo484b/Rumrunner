extends Button


func _ready() -> void:
# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")
# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_button_pressed")


func _on_mouse_entered() -> void:
	$HoverAnimationPlayer.play("hover")
	
	
func _on_mouse_exited() -> void:
	$HoverAnimationPlayer.play_backwards("hover")
	
	
func _on_button_pressed() -> void:
	$ClickAnimationPlayer.play("click")
