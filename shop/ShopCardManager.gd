extends CardManager


const SHOP_ID: int = 99

func _init() -> void:
	owner_id = SHOP_ID


func _on_ready() -> void:
	rng.randomize()
	card_1 = $Card
	card_2 = $Card2
	card_3 = $Card3
	card_4 = $Card4
	card_5 = null
	cards = [ card_1, card_2, card_3, card_4 ]
	build_deck(owner_id)
	draw_hand()


func discard_hand() -> void:
	for card in cards:
		discard(card.get_id())
		card.reset_card()
	shuffle_cards()
