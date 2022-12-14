extends CanvasLayer


signal back_pressed


const SHOP_ID: int = 98

var deck: Dictionary
var keys: Array


func build_deck(deck_owner: int) -> void:
	var deck_data = GameDatabase.get_data_by_id(GameDatabase.DECK_TABLE, "player_id", deck_owner)
	for card in deck_data:
		var added_card = GameDatabase.get_data_by_id(GameDatabase.CARD_TABLE, "id", card["id"])
		deck[added_card[0]["id"]] = added_card[0]


func _on_LineEdit_text_changed(new_text):
	if new_text == "":
		return
