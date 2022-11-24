extends MarginContainer


func _on_GameButton_pressed() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/MainMenu.tscn")
