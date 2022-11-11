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
onready var ai_card_manager: Node = $"../AiCardManager"
onready var card_manager: Node = $"../CardManager"
onready var incoming: MarginContainer = $"../IncomingAnnouncement"
onready var turn_timer: MarginContainer = $"../TurnTimer"


func _ready() -> void:
	if card_manager == null:
		push_error("card_manager not found!")


func start_ai_turn() -> void:
	current_turn = Turn.AI
	ai_card_manager.draw_hand()
	# AI places crd/cards
	show_incoming_banner()
	

func show_incoming_banner():
	incoming.display_incoming()


func start_player_turn() -> void:
	current_turn = Turn.PLAYER
	overlay.toggle_player_input()
	turn_timer.start_timer()


func resolve_cards() -> void:
	overlay.toggle_player_input()
	# Check for cards placed by AI
	# Check for cards placed by Player
	# Activate/resolve card effects
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


func _on_TurnTimer_player_time_out():
	resolve_cards()


func _on_IncomingAnnouncement_player_turn():
	start_player_turn()


func _on_GameOverlay_end_player_turn():
	var extra_time: int = turn_timer.stop_timer()
	overlay.add_progress(extra_time)
	resolve_cards()
