extends MarginContainer


const VALUE_INCREMENT: int = 10

onready var progress_bar: TextureProgress = $ProgressTexture
onready var tween: Tween = $ProgressTween


func add_progress(progress: int) -> void:
	var current_progress: int = progress_bar.value
	tween.interpolate_property(progress_bar, "value", current_progress, current_progress + progress, 0.99, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if not tween.is_active():
		tween.start()


func _on_ProgressTimer_timeout() -> void:
	if progress_bar.value < progress_bar.max_value:
		add_progress(self.VALUE_INCREMENT)
