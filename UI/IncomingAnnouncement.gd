extends MarginContainer


signal incoming
signal player_turn

onready var timer: Timer = $DisplayTimer


func display_incoming() -> void:
	self.raise()
	self.visible = true
	timer.start()
	

func _on_Timer_timeout() -> void:
	self.visible = false
	emit_signal("player_turn")


func _on_TurnTimer_player_time_out() -> void:
	emit_signal("incoming")
	display_incoming()
