# TODO remove print statements
extends Node


enum Turn { PLAYER, AI }

var current_turn: int = Turn.PLAYER
var player_card_positions: Dictionary = {
	"bow": null,
	"port": null,
	"starboard": null,
	"stern": null,
}
var ai_card_positions: Dictionary = {
	"bow": null,
	"port": null,
	"starboard": null,
	"stern": null,
}

onready var hand_manager: Node = $"../HandNodeManager"
onready var ship_node_manager: Node = $"../ShipNodeManager"
onready var overlay: CanvasLayer = $"../GameOverlay"
onready var card_manager: Node = $"../CardManager"


func _ready() -> void:
	if card_manager == null:
		push_error("card_manager not found!")


func start_player_turn() -> void:
	overlay.start_player_timer()


func _on_Card_placed(card_data, node):
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card2_placed(card_data, node):
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card3_placed(card_data, node):
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card4_placed(card_data, node):
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card5_placed(card_data, node):
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_GameOverlay_player_turn():
	current_turn = Turn.PLAYER


func _on_GameOverlay_ai_turn():
	current_turn = Turn.PLAYER
	# Run AI sequence
