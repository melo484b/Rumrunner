extends Node

var deck: Dictionary
var hand: Dictionary
var discard_pile: Dictionary
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	build_deck(Player.player_id)

func build_deck(player_id: int) -> void:
	var deck_data = GameDatabase.get_data_by_id(GameDatabase.DECK_TABLE, "player_id", Player.player_id)
	for card in deck_data:
		deck[card["id"]] = card

func draw_card() -> Dictionary:
	var pulled: int
	if self.deck.size() >= 1:
		var card_ids: Array = self.deck.keys()
		card_ids.shuffle()
		pulled = card_ids[0]
		hand[pulled] = self.deck.get(pulled)
		self.deck.erase(pulled)
		return hand.get(pulled)
	else:
		shuffle()
		var card_ids: Array = self.deck.keys()
		card_ids.shuffle()
		pulled = card_ids[0]
		hand[pulled] = self.deck.get(pulled)
		self.deck.erase(pulled)
		return hand.get(pulled)
	
func discard(card_id: int) -> void:
	if (hand.has(card_id)):
		self.discard_pile[card_id] = self.hand.get(card_id)
		self.hand.erase(card_id)

func shuffle() -> void:
	self.deck.merge(discard_pile)
	self.discard_pile.clear()
