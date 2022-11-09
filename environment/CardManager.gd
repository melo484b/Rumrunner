extends Node

var deck: Dictionary
var hand: Dictionary
var discard_pile: Dictionary
var player_cards: Array
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var card_1: RigidBody2D = $"../CardManager/Card"
onready var card_2: RigidBody2D = $"../CardManager/Card2"
onready var card_3: RigidBody2D = $"../CardManager/Card3"
onready var card_4: RigidBody2D = $"../CardManager/Card4"
onready var card_5: RigidBody2D = $"../CardManager/Card5"

func _ready() -> void:
	rng.randomize()
	build_deck(Player.player_id)
	player_cards = [ card_1, card_2, card_3, card_4, card_5 ]
	draw_player_hand()
	

func build_deck(player_id: int) -> void:
	var deck_data = GameDatabase.get_data_by_id(GameDatabase.DECK_TABLE, "player_id", player_id)
	for card in deck_data:
		deck[card["id"]] = card
	print(self.deck)

func build_card(card_data: Dictionary) -> Dictionary:
	if !card_data.empty():
		var card = GameDatabase.get_data_by_id(GameDatabase.CARD_TABLE, "id", card_data.get("id"))
		print(card)
		return card
	return Dictionary()

# TODO add a check for "number_of_copies"
func draw_card() -> Dictionary:
	var pulled: int
	if self.deck.size() >= 1:
		var card_ids: Array = self.deck.keys()
		card_ids.shuffle()
		pulled = card_ids[0]
		hand[pulled] = self.deck.get(pulled)
		self.deck.erase(pulled)
		return hand.get(pulled)
	elif self.discard_pile.size() >= 1:
		shuffle_cards()
		var card_ids: Array = self.deck.keys()
		card_ids.shuffle()
		pulled = card_ids[0]
		hand[pulled] = self.deck.get(pulled)
		self.deck.erase(pulled)
		return hand.get(pulled)
	else:
		return Dictionary()
	
func discard(card_id: int) -> void:
	if (hand.has(card_id)):
		self.discard_pile[card_id] = self.hand.get(card_id)
		self.hand.erase(card_id)

func shuffle_cards() -> void:
	self.deck.merge(discard_pile)
	self.discard_pile.clear()

func draw_player_hand() -> void:
	for card in player_cards:
		var new_card: Dictionary = build_card(draw_card())[0]
		card.call("set_card_data", new_card)
		card.call("populate_card_data")
