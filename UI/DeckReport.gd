extends CanvasLayer


signal back_pressed


var id_to_check: int = 1
var card_record: PackedScene = preload("res://UI/CardRecord.tscn")
var deck: Dictionary
var keys: Array

onready var title_label: Label = $MarginContainer/PanelContainer/MarginContainer/ReportTable/Panel/CenterContainer/ReportTitle
onready var table: MarginContainer = $MarginContainer/PanelContainer/MarginContainer/ReportTable
onready var records: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/ReportTable/Panel/MarginContainer/ScrollContainer/Records
onready var buttons: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/CenterContainer/Buttons


func _ready() -> void:
	set_button_text()


func set_button_text() -> void:
	var player_id: int = 1
	for button in buttons.get_children():
		if button.name != "Back":
			var player_name = GameDatabase.get_data_by_id(GameDatabase.PLAYER_TABLE, "id", player_id)
			button.text = player_name[0].get("name")
			player_id += 1


func pull_report(deck_owner_id: int) -> void:
	deck.clear()
	build_deck(deck_owner_id)
	keys = deck.keys()
	for key in keys:
		var record = card_record.instance()
		records.add_child(record)
		record.set_record_data(str(deck.get(key)["id"]), deck.get(key)["name"], deck.get(key)["card_class"], str(deck.get(key)["art_id"]), deck.get(key)["description"], str(deck.get(key)["offensive_stat"]), str(deck.get(key)["defensive_stat"]), str(deck.get(key)["cost"]))


func build_deck(deck_owner: int) -> void:
	var deck_data = GameDatabase.get_data_by_id(GameDatabase.DECK_TABLE, "player_id", deck_owner)
	for card in deck_data:
		var added_card = GameDatabase.get_data_by_id(GameDatabase.CARD_TABLE, "id", card["id"])
		deck[added_card[0]["id"]] = added_card[0]


func set_report_title(player_id: int) -> void:
	var player_name = GameDatabase.get_data_by_id(GameDatabase.PLAYER_TABLE, "id", player_id)
	var date_time_stamp = Time.get_datetime_string_from_system(false, true)
	title_label.text = str(player_name[0].get("name")) + "'s Deck Report - " + date_time_stamp


func show_table() -> void:
	table.visible = true
	

func hide_table() -> void:
	table.visible = false


func _on_CloseReportButton_button_down() -> void:
	hide_table()
	for record in records.get_children():
		if record.name != "AttributeLabels":
			record.queue_free()


func _on_CheckPlayer1_pressed() -> void:
	pull_report(1)
	set_report_title(1)
	show_table()


func _on_CheckPlayer2_pressed() -> void:
	pull_report(2)
	set_report_title(2)
	show_table()


func _on_CheckPlayer3_pressed() -> void:
	pull_report(3)
	set_report_title(3)
	show_table()


func _on_Back_pressed() -> void:
	emit_signal("back_pressed")
