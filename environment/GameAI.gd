extends Node


var current_rum: int = 20
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
	card_manager.draw_hand()
	overlay.unblock_player_input()
	turn_timer.start_timer()


func resolve_cards() -> void:
	var combat_result: Vector2
	overlay.block_player_input()
	combat_result = compare_cards()
	modify_rum_after_combat(combat_result)
	# TODO: activate card effects
	ai_card_manager.discard_hand()
	reset_ai_card_positions()
	reset_player_card_positions()
	start_ai_turn()


func compare_cards() -> Vector2:
	var offense_result: Array = [0, 0, 0, 0]
	var defense_result: Array = [0, 0, 0, 0]
	var current_index: int = 0
	for p_card in player_card_positions:
		if !p_card.empty():
			offense_result[current_index] = p_card["offensive_stat"]
			defense_result[current_index] = p_card["defensive_stat"]
		else:
			offense_result[current_index] = 0
			defense_result[current_index] = 0
		current_index += 1
	current_index = 0
	for ai_card in ai_card_positions:
		if !ai_card.empty():
			offense_result[current_index] -= ai_card["defensive_stat"]
			defense_result[current_index] -= ai_card["offensive_stat"]
		current_index += 1
	var offense_sum: int
	var defense_sum: int
	for i in offense_result:
		offense_sum += i
	for j in defense_result:
		defense_sum += j
	print(offense_result)
	print(defense_result)
	return Vector2(offense_sum, defense_sum)


func modify_rum_after_combat(combat_outcome: Vector2) -> void:
	if combat_outcome.x < 0:
		pass # TODO: vfx & sfx to indicate nothing happens
	elif combat_outcome.x > 0:
		print(combat_outcome.x)
		gain_rum(combat_outcome.x)
	if combat_outcome.y < 0:
		print(combat_outcome.y)
		lose_rum(combat_outcome.y)
	elif combat_outcome.y > 0:
		pass # TODO: vfx & sfx to indicate nothing happens
	score_counter.update_score(current_rum)


func reset_ai_card_positions() -> void:
	ai_card_positions = [{}, {}, {}, {}]


func reset_player_card_positions() -> void:
	player_card_positions = [{}, {}, {}, {}]


func gain_rum(rum_gained: int) -> void:
	current_rum += rum_gained
	

func lose_rum(rum_lost: int) -> void:
	current_rum -= abs(rum_lost)


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
	overlay.draw_card_animation()


func _on_GameOverlay_end_player_turn():
	var extra_time: int = turn_timer.stop_timer()
	overlay.add_progress(extra_time)
	resolve_cards()
	card_manager.discard_hand()


func _on_GameOverlay_start_level():
	start_ai_turn()
