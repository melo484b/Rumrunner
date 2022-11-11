extends CardManager


const AI_ID: int = 99
const POSITIONS: Array = [Vector2(820, 231), Vector2(504, 117), Vector2(501, 328), Vector2(201, 227)]
const LOCATIONS: Array = ["bow", "port", "starboard", "stern"]

func _init():
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


func place_card(location: String, new_position: Vector2, card: Card) -> void:
	card.set_placed(location)
	card.set_position(new_position)
	card.set_physics_process(false)
	
	
