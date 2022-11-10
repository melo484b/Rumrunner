extends CanvasLayer


signal level_complete

const MAX_LEVEL_TIME: int = 120

var level_time: int = MAX_LEVEL_TIME
var time_left: int

onready var deck: TextureRect = $CardBackTexture
onready var progress_timer: Timer = $ProgressTimer


func _ready() -> void:
	progress_timer.start()


func draw_card_animation() -> void:
	deck.draw_animation()


func remove_time(time_to_remove: int) -> void:
	self.level_time -= time_to_remove


func _on_ProgressTimer_timeout() -> void:
	if self.level_time > 0:
		self.level_time -= 1
	else:
		progress_timer.stop()
		time_left = MAX_LEVEL_TIME - level_time
		emit_signal("level_complete", time_left)
	$DeleteMeAfterTesting.text = str(self.level_time)
	
