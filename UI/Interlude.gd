extends CanvasLayer


func _on_ReturnToMainMenu_pressed() -> void:
	get_tree().change_scene("res://UI/MainMenu.tscn")


func _on_NextRun_pressed() -> void:
	get_tree().change_scene("res://environment/GameEnvironment.tscn")
