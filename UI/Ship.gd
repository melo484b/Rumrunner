extends Node2D

onready var animator: AnimationPlayer = $AnimationPlayer

func _ready():
	animator.play("sway_port_starboard")
