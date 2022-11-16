extends Node2D


onready var overlay: CanvasLayer = $GameOverlay
onready var ai: Node = $GameAI


func _on_GameOverlay_level_complete() -> void:
	overlay.set_score_tally_rum(ai.current_rum)
	overlay.tally_score()
