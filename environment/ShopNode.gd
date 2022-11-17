extends CardNode


signal occupied_by_card(card_data)

onready var cards: Array = get_tree().get_nodes_in_group("CARD")


func _ready():
	select()


func select() -> void:
	modulate = Color.aqua
	self.selected = true
	self.filled = true
	var card_held: Card
	for card in cards:
		var distance = global_position.distance_to(card.global_position)
		if distance < 100 and selected:
			card_held = card
	if card_held != null:
		emit_signal("occupied_by_card", card_held.card_data)
		print(name + " occupied by " + str(card_held.name))
