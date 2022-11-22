extends MarginContainer


func _on_GameButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/MainMenu.tscn")
