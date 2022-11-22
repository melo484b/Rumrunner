extends MarginContainer


signal progress_complete(level_time)

const MAX_VALUE: int = 1200
const LEVEL_SECONDS: float = 60.0

var time_left: int

onready var progress_bar: TextureProgress = $ProgressTexture
onready var tween: Tween = $ProgressTween
onready var timer: Timer = $Timer


func add_progress(progress: int) -> void:
	var current_time: float = tween.tell()
	progress_bar.value += progress
	if tween.is_active():
# warning-ignore:return_value_discarded
		tween.seek(clamp(current_time + float(progress), 0.0, LEVEL_SECONDS))


func get_level_time() -> int:
	return int(tween.tell())


func start_level_progress_bar() -> void:
# warning-ignore:return_value_discarded
	tween.interpolate_property(progress_bar, "value", 0, MAX_VALUE, LEVEL_SECONDS, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if not tween.is_active():
# warning-ignore:return_value_discarded
		tween.start()
	timer.start()


func stop_level_progress_bar() -> int:
	var time_remaining: int = int(timer.time_left)
	timer.stop()
	return time_remaining


func _on_ProgressTexture_value_changed(value) -> void:
	if value >= MAX_VALUE:
		time_left = stop_level_progress_bar()
		print(time_left)
		emit_signal("progress_complete", time_left)
