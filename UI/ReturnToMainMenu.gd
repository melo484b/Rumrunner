extends MarginContainer

func _on_GameButton_pressed() -> void:
	get_tree().change_scene("res://UI/MainMenu.tscn")
