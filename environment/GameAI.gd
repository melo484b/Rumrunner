extends Node


enum Turn { PLAYER, AI }

var current_turn: int = Turn.AI
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


func start_ai_turn() -> void:
	current_turn = Turn.AI
	# Block player input
	# AI draws cards
	# AI places crd/cards
	# show_incoming_banner()
	

func show_incoming_banner():
	pass
	# Show incoming banner
	# Allow player input
	# start_player_turn()


func start_player_turn() -> void:
	current_turn = Turn.PLAYER
	# Start player turn timer
	# Player makes moves
	# Player ends turn OR runs out of time:
	#	resolve_cards()


func resolve_cards() -> void:
	pass
	# Check for cards placed by AI
	# Check for cards placed by Player
	# Activate card effects
	# start_ai_turn()


func _on_Card_placed(card_data, node) -> void:
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card2_placed(card_data, node) -> void:
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card3_placed(card_data, node) -> void:
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card4_placed(card_data, node) -> void:
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_Card5_placed(card_data, node) -> void:
	player_card_positions[node] = card_data
	print(player_card_positions)


func _on_AiCard_placed(card_data, node) -> void:
	ai_card_positions[node] = card_data
	print(ai_card_positions)


func _on_AiCard2_placed(card_data, node) -> void:
	ai_card_positions[node] = card_data
	print(ai_card_positions)


func _on_AiCard3_placed(card_data, node) -> void:
	ai_card_positions[node] = card_data
	print(ai_card_positions)


func _on_AiCard4_placed(card_data, node) -> void:
	ai_card_positions[node] = card_data
	print(ai_card_positions)


func _on_AiCard5_placed(card_data, node) -> void:
	ai_card_positions[node] = card_data
	print(ai_card_positions)
