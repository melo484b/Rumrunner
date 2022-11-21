extends CardNode


signal occupied_by_card(card_data)
signal unoccupied

var card_held: Card

onready var cards: Array = get_tree().get_nodes_in_group("CARD")


func _ready() -> void:
	_on_ready()


func _on_ready():
	yield(get_tree().root, "ready")
	get_nearby_card()


func select() -> void:
	modulate = Color.aqua
	selected = true
	filled = true
	if card_held != null:
		emit_signal("occupied_by_card", card_held.card_data)
		print(name + " occupied by " + str(card_held.name))


func deselect() -> void:
	modulate = Color.white
	selected = false
	filled = false
	emit_signal("unoccupied")
	

func get_nearby_card() -> void:
	if card_held == null:
		card_held = cards[0]
	for card in cards:
		if card.global_position.distance_to(self.global_position) < card_held.global_position.distance_to(self.global_position):
			if card.global_position.distance_to(self.global_position) <= 50:
				card_held = card
				select()
			else:
				deselect()
