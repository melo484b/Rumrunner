extends Node2D


onready var overlay: CanvasLayer = $GameOverlay
onready var ai: Node = $GameAI


func _ready() -> void:
	AmbientWaves.stream_paused = true


func _on_GameOverlay_level_complete() -> void:
	overlay.set_score_tally_rum(ai.current_rum)
	overlay.tally_score()


func _on_GameOverlay_change_scene_to_shop() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
	AmbientWaves.stream_paused = false
	get_tree().change_scene("res://shop/CardShop.tscn")
