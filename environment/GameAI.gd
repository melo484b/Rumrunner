extends Node

onready var card_manager: Node = $"../CardManager"

enum { PLAYER_TURN, AI_TURN }

func _ready() -> void:
	if card_manager == null:
		push_error("card_manager not found!")

