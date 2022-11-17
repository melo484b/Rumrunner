extends CanvasLayer


func _on_ReturnToMainMenu_pressed():
	get_tree().change_scene("res://UI/MainMenu.tscn")


func _on_NextRun_pressed():
	get_tree().change_scene("res://environment/GameEnvironment.tscn")
