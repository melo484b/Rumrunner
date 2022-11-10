extends CardManager


const AI_ID: int = 99

func _ready():
	card_1 = $Card
	card_2 = $Card2
	card_3 = $Card3
	card_4 = $Card4
	card_5 = $Card5
	build_deck(AI_ID)
	cards = [ card_1, card_2, card_3, card_4, card_5 ]


func draw_ai_hand() -> void:
	for card in cards:
		var new_card: Dictionary = build_card(draw_card())[0]
		card.call("set_card_data", new_card)
		card.call("populate_card_data")


func place_card(location: String, position: Vector2, card: Card):
	card.set_placed(location)


func _on_GameOverlay_ai_turn():
	pass
