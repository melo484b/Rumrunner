extends CanvasLayer


signal back_pressed


var ui_card: PackedScene = preload("res://card/UIcard.tscn")
var deck: Dictionary
var matched_cards: Array

onready var records: VBoxContainer = $MarginContainer/ScrollContainer/Records


func _ready() -> void:
	_on_ready()


func _on_ready() -> void:
	build_deck()
	generate_ui_cards()


func build_deck() -> void:
	var deck_data = GameDatabase.get_all_data_in_table(GameDatabase.CARD_TABLE)
	for card in deck_data:
		var added_card = GameDatabase.get_data_by_id(GameDatabase.CARD_TABLE, "id", card["id"])
		deck[added_card[0]["id"]] = added_card[0]


func generate_ui_cards() -> void:
	for card in deck:
		var gen_card = ui_card.instance()
		records.add_child(gen_card)
		gen_card.set_card_data(deck.get(card))
		gen_card.populate_card_data()
		


func _on_LineEdit_text_changed(new_text: String) -> void:
	if new_text == "":
		for card in records.get_children():
			card.visible = true
		return
	for card in records.get_children():
		if new_text.to_lower() in card.get_card_name():
			card.visible = true
		else:
			card.visible = false


func _on_GameButton_pressed() -> void:
	emit_signal("back_pressed")
