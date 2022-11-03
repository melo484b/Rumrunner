extends Node

var deck: Dictionary
var card: Dictionary
var hand: Dictionary
var discarded: Dictionary

func _ready():
	pass

# Get cards ID's associated with player ID
# Iterate through list of card ID's
# 	Call build_card() to get card data for each card_id-
#	Add card data to deck dictionary
func build_deck(player_id: int) -> Dictionary:
	return Dictionary()

# Retrieve card with specific card ID from the database
# Add card data to dictionary
# Return dictionary 
func build_card(card_id: int) -> Dictionary:
	return Dictionary()

# Return a randomly selected card - to be used by CardManager to access
# card data
# Move card from deck to hand
func draw_card() -> Dictionary:
	return Dictionary()

# Move card from hand to discard
func discard() -> void:
	pass

# Move all cards from discard to deck
func shuffle() -> void:
	pass
