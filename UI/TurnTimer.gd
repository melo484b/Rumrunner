class_name TurnTimer
extends MarginContainer


signal player_time_out

var active: bool = true

onready var timer: Timer = $Timer
onready var tween: Tween = $TimerTween
onready var progress_texture: TextureProgress = $PanelContainer/MarginContainer/CenterContainer/TextureProgress
onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	pass


func start_timer() -> void:
	timer.start()
	tween.interpolate_property(progress_texture, "value", 0, 60, 6.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if not tween.is_active():
		tween.start()


func stop_timer() -> int:
	var time_left: int = round(timer.time_left)
	timer.stop()
	tween.stop(progress_texture, "value")
	return int(time_left)


func _on_Timer_timeout() -> void:
	animation.play("shake")
	if active:
		emit_signal("player_time_out")


func _on_GameOverlay_level_complete() -> void:
	active = false
