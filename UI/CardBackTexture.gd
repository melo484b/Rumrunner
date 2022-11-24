extends TextureRect


onready var animator: AnimationPlayer = $AnimationPlayer
onready var timer: Timer = $Timer
onready var shuffle_sfx: Node = $CardSFXplayer


func draw_animation() -> void:
	animator.play("draw_card")
	timer.start()
	shuffle_sfx.play()


func _on_Timer_timeout() -> void:
	animator.stop()
