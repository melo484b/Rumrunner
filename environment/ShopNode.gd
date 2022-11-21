extends CardNode


signal occupied_by_card(card_data)

var card_held: Card

onready var cards: Array = get_tree().get_nodes_in_group("CARD")


func _ready() -> void:
	select()


func select() -> void:
	modulate = Color.aqua
	self.selected = true
	self.filled = true
	for card in cards:
		var distance = global_position.distance_to(card.global_position)
		if distance < 100 and selected:
			card_held = card
	if card_held != null:
		emit_signal("occupied_by_card", card_held.card_data)
		print(name + " occupied by " + str(card_held.name))
