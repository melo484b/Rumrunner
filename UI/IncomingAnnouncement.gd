extends MarginContainer


signal player_turn

onready var timer: Timer = $DisplayTimer


func display_incoming() -> void:
	self.raise()
	self.visible = true
	timer.start()
	

func _on_Timer_timeout() -> void:
	self.visible = false
	emit_signal("player_turn")
