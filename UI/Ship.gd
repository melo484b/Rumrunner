extends Node2D

onready var animator: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animator.play("sway_port_starboard")


func _on_GameOverlay_level_complete() -> void:
	animator.play("level_success")
