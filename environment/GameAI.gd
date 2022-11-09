extends Node

onready var card_manager: Node = $"../CardManager"

enum Turn { PLAYER, AI }

var current_turn: int = Turn.PLAYER

func _ready() -> void:
	if card_manager == null:
		push_error("card_manager not found!")
