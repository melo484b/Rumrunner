extends Node

onready var deck_manager: Node = $"../DeckManager"
onready var card_manager: Node = $"../CardManager"

func _ready():
	
	if deck_manager == null:
		push_error("deck_manager not found!")
	if card_manager == null:
		push_error("card_manager not found!")
