extends Sprite


const ROLL_DURATION: float = 0.2
const MAX_FRAME: int = 5

var rng = RandomNumberGenerator.new()

onready var tween: Tween = $Tween


func roll_the_die() -> void:
	rng.randomize()
# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "frame", 0, MAX_FRAME, ROLL_DURATION, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if not tween.is_active():
# warning-ignore:return_value_discarded
		tween.start()
	else:
# warning-ignore:return_value_discarded
		tween.reset(self, "frame")
	yield(tween, "tween_completed")
	self.set_frame(rng.randi_range(0, 5))
