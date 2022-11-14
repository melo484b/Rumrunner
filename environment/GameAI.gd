extends Node


var current_rum: int = 20 setget set_current_rum
var player_card_positions: Array = [{}, {}, {}, {}]
var ai_card_positions: Array = [{}, {}, {}, {}]

onready var hand_manager: Node = $"../HandNodeManager"
onready var ship_node_manager: Node = $"../ShipNodeManager"
onready var overlay: CanvasLayer = $"../GameOverlay"
onready var ai_card_manager: Node = $"../AiCardManager"
onready var card_manager: Node = $"../CardManager"
onready var incoming: MarginContainer = $"../IncomingAnnouncement"
onready var turn_timer: MarginContainer = $"../TurnTimer"
onready var score_counter: MarginContainer = $"../ScoreCounter"


func _ready() -> void:
	if card_manager == null:
		push_error("card_manager not found!")


func start_ai_turn() -> void:
	ai_card_manager.draw_hand()
	ai_card_manager.place_card()
	show_incoming_banner()
	

func show_incoming_banner():
	incoming.display_incoming()


func start_player_turn() -> void:
	overlay.unblock_player_input()
	turn_timer.start_timer()


func resolve_cards() -> void:
	overlay.block_player_input()
	# Check for cards placed by AI
	# Check for cards placed by Player
	# Activate/resolve card effects
	ai_card_manager.discard_hand()
	reset_ai_card_positions()
	reset_player_card_positions()
	start_ai_turn()


func compare_cards(player_cards: Dictionary, ai_cards: Dictionary) -> void:
	pass


func reset_ai_card_positions() -> void:
	ai_card_positions = [{}, {}, {}, {}]


func reset_player_card_positions() -> void:
	player_card_positions = [{}, {}, {}, {}]


func set_current_rum(new_rum: int) -> void:
	current_rum = new_rum
	score_counter.set_score_counter_label(current_rum)


func _on_Card_placed(card_data, index) -> void:
	player_card_positions[index] = card_data


func _on_Card2_placed(card_data, index) -> void:
	player_card_positions[index] = card_data


func _on_Card3_placed(card_data, index) -> void:
	player_card_positions[index] = card_data


func _on_Card4_placed(card_data, index) -> void:
	player_card_positions[index] = card_data


func _on_Card5_placed(card_data, index) -> void:
	player_card_positions[index] = card_data


func _on_AiCard_placed(card_data, index) -> void:
	ai_card_positions[index] = card_data


func _on_AiCard2_placed(card_data, index) -> void:
	ai_card_positions[index] = card_data


func _on_AiCard3_placed(card_data, index) -> void:
	ai_card_positions[index] = card_data


func _on_AiCard4_placed(card_data, index) -> void:
	ai_card_positions[index] = card_data


func _on_AiCard5_placed(card_data, index) -> void:
	ai_card_positions[index] = card_data


func _on_TurnTimer_player_time_out():
	resolve_cards()
	card_manager.discard_hand()


func _on_IncomingAnnouncement_player_turn():
	start_player_turn()


func _on_GameOverlay_end_player_turn():
	var extra_time: int = turn_timer.stop_timer()
	overlay.add_progress(extra_time)
	resolve_cards()
	card_manager.discard_hand()


func _on_GameOverlay_start_level():
	start_ai_turn()
