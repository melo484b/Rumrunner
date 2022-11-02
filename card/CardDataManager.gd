extends Node

var data: Array = Array()

func _ready() -> void:
	get_card_data()
	print(data)

func get_card_data() -> void:
	data = GameDatabase.get_all_data_in_table(GameDatabase.CARD_TABLE)

# select from deck where player_id = Player.id
# for card_id in query
# add card id to Player.playerCards
