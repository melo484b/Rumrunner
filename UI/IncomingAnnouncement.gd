class_name IncomingAnnouncement
extends MarginContainer


signal player_turn

onready var timer: Timer = $DisplayTimer


func display_incoming() -> void:
	visible = true
	timer.start()
	

func _on_Timer_timeout() -> void:
	visible = false
	emit_signal("player_turn")
