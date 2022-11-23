extends CardNode


var card_held: Card

onready var cost_display: MarginContainer = $CardCostDisplay
onready var cards: Array = get_tree().get_nodes_in_group("CARD")


func _ready() -> void:
	_on_ready()


func _on_ready() -> void:
	yield(get_tree().root, "ready")
	select()


func select() -> void:
	modulate = Color.aqua
	selected = true
	filled = true
	card_held = get_nearest_card()
	if card_held != null:
		cost_display.set_cost(card_held.card_data["cost"])
		print(name + " occupied by " + str(card_held.name))


func deselect() -> void:
	modulate = Color.white
	selected = false
	filled = false
	cost_display.set_empty()


func get_nearest_card() -> Card:
	for card in cards:
		if card.global_position.distance_to(self.global_position) < 100:
			return card
	return null
