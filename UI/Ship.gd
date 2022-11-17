extends Node2D

onready var animator: AnimationPlayer = $AnimationPlayer

func _ready():
	animator.play("sway_port_starboard")


func _on_GameOverlay_level_complete():
	animator.play("level_success")
