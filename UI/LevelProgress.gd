extends MarginContainer


onready var progress_bar: TextureProgress = $ProgressTexture


func _on_ProgressTimer_timeout():
	if progress_bar.value < 120:
		progress_bar.value += 1
