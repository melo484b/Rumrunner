extends CanvasLayer


func _on_ReturnToMainMenu_pressed() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	get_tree().change_scene("res://UI/MainMenu.tscn")


func _on_NextRun_pressed() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	get_tree().change_scene("res://environment/GameEnvironment.tscn")
