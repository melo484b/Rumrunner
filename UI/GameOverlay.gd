extends CanvasLayer


signal level_complete

const MAX_LEVEL_TIME: int = 120
const TIME_DECREMENT: int = 1
const TIME_MINIMUM: int = 0
const PROGRESS_TIME_MULTIPLIER: int = 10

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
	if self.level_time > TIME_MINIMUM:
		self.level_time -= TIME_DECREMENT
	elif self.level_time <= TIME_MINIMUM:
		self.level_time = TIME_MINIMUM
	$DeleteMeAfterTesting.text = str(self.level_time)
	


func _on_ProgressTexture_value_changed(value):
	if value >= self.MAX_LEVEL_TIME * PROGRESS_TIME_MULTIPLIER:
		progress_timer.stop()
		emit_signal("level_complete", self.level_time)
		print("level complete" + str(self.level_time))
