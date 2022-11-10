extends TextureRect


onready var animator: AnimationPlayer = $AnimationPlayer
onready var timer: Timer = $Timer


func draw_animation() -> void:
	animator.play("draw_card")
	timer.start()


func _on_Timer_timeout() -> void:
	animator.stop()
