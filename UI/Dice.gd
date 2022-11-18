extends Sprite


const ROLL_DURATION: float = 0.2
const MAX_FRAME: int = 5

var rng = RandomNumberGenerator.new()

onready var tween: Tween = $Tween


func roll_the_die() -> void:
	rng.randomize()
	tween.interpolate_property(self, "frame", 0, MAX_FRAME, ROLL_DURATION, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if not tween.is_active():
		tween.start()
	else:
		tween.restart()
	yield(tween, "tween_completed")
	self.set_frame(rng.randi_range(0, 5))


func _on_RerollButton_pressed():
	roll_the_die()
