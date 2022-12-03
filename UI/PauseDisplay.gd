extends MarginContainer


func _on_PauseDisplay_tree_exiting():
	get_tree().paused = false
