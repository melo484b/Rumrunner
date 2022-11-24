class_name TurnTimer
extends MarginContainer


signal player_time_out

var active: bool = true

onready var timer: Timer = $Timer
onready var tween: Tween = $TimerTween
onready var progress_texture: TextureProgress = $PanelContainer/MarginContainer/CenterContainer/TextureProgress
onready var animation: AnimationPlayer = $AnimationPlayer
onready var bell_sfx: Node = $BellSFXplayer


func _ready() -> void:
	pass


func start_timer() -> void:
	timer.start()
# warning-ignore:return_value_discarded
	tween.interpolate_property(progress_texture, "value", 0, 60, 6.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if not tween.is_active():
# warning-ignore:return_value_discarded
		tween.start()


func stop_timer() -> int:
# warning-ignore:narrowing_conversion
	var time_left: int = round(timer.time_left)
	timer.stop()
# warning-ignore:return_value_discarded
	tween.stop(progress_texture, "value")
	return int(time_left)


func _on_Timer_timeout() -> void:
	bell_sfx.play()
	animation.play("shake")
	if active:
		emit_signal("player_time_out")


func _on_GameOverlay_level_complete() -> void:
	active = false
