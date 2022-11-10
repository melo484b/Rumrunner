extends MarginContainer


signal incoming

onready var timer: Timer = $DisplayTimer


func display_incoming() -> void:
	self.visible = true
	timer.start()
	

func _on_Timer_timeout() -> void:
	self.visible = false
	emit_signal("incoming")


func _on_TurnTimer_player_time_out():
	display_incoming()
