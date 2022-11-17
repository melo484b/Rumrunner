extends CardManager


signal ai_ready

const AI_ID: int = 99
const NODE_INDEX_RANGE: int = 3
const CARD_INDEX_RANGE: int = 4
const POSITIONS: Array = [Vector2(820, 240), Vector2(504, 137), Vector2(499, 328), Vector2(232, 240)]
const LOCATIONS: Array = ["bow", "port", "starboard", "stern"]

var level_in_progess: bool = true


func _init() -> void:
	owner_id = AI_ID


func _on_ready() -> void:
	rng.randomize()
	card_1 = $AiCard
	card_2 = $AiCard2
	card_3 = $AiCard3
	card_4 = $AiCard4
	card_5 = $AiCard5
	cards = [ card_1, card_2, card_3, card_4, card_5 ]
	build_deck(owner_id)
	draw_hand()
	yield(get_tree().root, "ready")
	emit_signal("ai_ready")


func place_card() -> void:
	if level_in_progess:
		rng.randomize()
		var node_index: int = rng.randi_range(0, NODE_INDEX_RANGE)
		var card_index: int = rng.randi_range(0, CARD_INDEX_RANGE)
		cards[card_index].set_target_position(POSITIONS[node_index])
		cards[card_index].set_placed(LOCATIONS[node_index])


func discard_hand() -> void:
	for card in cards:
		discard(card.get_id())
		card.reset_card()
	shuffle_cards()


func _on_GameOverlay_level_complete() -> void:
	level_in_progess = false
	for card in cards:
		card.spin()
	discard_hand()
