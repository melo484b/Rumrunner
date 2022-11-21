class_name CardManager
extends Node


signal player_hand_discarded

var associated_cards: Dictionary
var deck: Dictionary
var hand: Dictionary
var discard_pile: Dictionary
var cards: Array
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var owner_id: int = Player.player_id

onready var card_1: RigidBody2D
onready var card_2: RigidBody2D
onready var card_3: RigidBody2D
onready var card_4: RigidBody2D
onready var card_5: RigidBody2D


func _init() -> void:
	owner_id = Player.player_id


func _ready() -> void:
	_on_ready()


func _on_ready() -> void:
	card_1 = $"../CardManager/Card"
	card_2 = $"../CardManager/Card2"
	card_3 = $"../CardManager/Card3"
	card_4 = $"../CardManager/Card4"
	card_5 = $"../CardManager/Card5"
	rng.randomize()
	cards = [ card_1, card_2, card_3, card_4, card_5 ]
	build_deck(owner_id)
	draw_hand()
	
	
func build_deck(owner_id: int) -> void:
	var deck_data = GameDatabase.get_data_by_id(GameDatabase.DECK_TABLE, "player_id", owner_id)
	for card in deck_data:
		var added_card = GameDatabase.get_data_by_id(GameDatabase.CARD_TABLE, "id", card["id"])
		deck[added_card[0]["id"]] = added_card[0]


# TODO add a check for "number_of_copies"
func draw_card() -> Dictionary:
	rng.randomize()
	var pulled: int
	if self.deck.size() >= 1:
		var card_ids: Array = deck.keys()
		card_ids.shuffle()
		pulled = card_ids[rng.randi_range(0, card_ids.size() - 1)]
		hand[pulled] = deck.get(pulled)
		deck.erase(pulled)
		return hand.get(pulled)
	elif discard_pile.size() >= 1:
		shuffle_cards()
		var card_ids: Array = deck.keys()
		card_ids.shuffle()
		pulled = card_ids[0]
		hand[pulled] = deck.get(pulled)
		deck.erase(pulled)
		return hand.get(pulled)
	else:
		return Dictionary()
	
	
func discard(card_id: int) -> void:
	if (hand.has(card_id)):
		discard_pile[card_id] = hand.get(card_id)
		hand.erase(card_id)


func shuffle_cards() -> void:
	deck.merge(discard_pile)
	discard_pile.clear()


func draw_hand() -> void:
	for card in cards:
		card.animator.play("shuffle")
		card.call("set_card_data", draw_card())
		card.call("populate_card_data")


func discard_hand() -> void:
	for card in cards:
		discard(card.get_id())
		card.reset_card()
	shuffle_cards()
	emit_signal("player_hand_discarded")


func _on_GameOverlay_level_complete() -> void:
	for card in cards:
		card.spin()
	discard_hand()
