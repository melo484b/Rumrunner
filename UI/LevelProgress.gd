extends MarginContainer


const MAX_VALUE: int = 1200
const LEVEL_SECONDS: float = 120.0

var time_left: int

onready var progress_bar: TextureProgress = $ProgressTexture
onready var tween: Tween = $ProgressTween
onready var timer: Timer = $Timer


func _ready():
	start_level_progress_bar()


func add_progress(progress: int) -> void:
	var current_time: float = tween.tell()
	progress_bar.value += progress
	if tween.is_active():
		tween.seek(current_time + float(progress/10))


func start_level_progress_bar() -> void:
	tween.interpolate_property(progress_bar, "value", 0, MAX_VALUE, LEVEL_SECONDS, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if not tween.is_active():
		tween.start()
	timer.start()


func stop_level_progress_bar() -> int:
	var time_left: int = int(timer.time_left)
	timer.stop()
	return time_left


func _on_ProgressTexture_value_changed(value) -> void:
	if value >= MAX_VALUE:
		time_left = stop_level_progress_bar()
