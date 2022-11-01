extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db
var db_name: String = "res://database/data/rumrunner"

const PLAYER_TABLE: String = "player"
const CARD_TABLE: String = "card"
const DECK_TABLE: String = "deck"

func _ready():
	db = SQLite.new()
	db.path = db_name


func add_new_player(name: String, currency: int, score: int) -> void:
	db.open_db()
	var data: Dictionary = Dictionary()
	data["name"] = name
	data["currency"] = currency
	data["score"] = score
	db.insert_row(PLAYER_TABLE, data)

# TODO
func update_player_data() -> void:
	pass

func add_new_card(name: String, card_class: String, art_id: int, 
description_1: String, description_2: String, description_3: String, 
offensive_stat: int, defensive_stat: int, value: int) -> void:
	db.open_db()
	var data: Dictionary = Dictionary()
	data["name"] = name
	data["card_class"] = card_class
	data["art_id"] = art_id
	data["description_1"] = description_1
	data["description_2"] = description_2
	data["description_3"] = description_3
	data["offensive_stat"] = offensive_stat
	data["defensive_stat"] = defensive_stat
	data["value"] = value
	db.insert_row(CARD_TABLE, data)

# TODO
func update_card_data() -> void:
	pass

func associate_new_card_with_player(player_id: int, card_id: int, number_of_copies: int) -> void:
	db.open_db()
	var data: Dictionary = Dictionary()
	data["player_id"] = player_id
	data["card_id"] = card_id
	data["number_of_copies"] = number_of_copies
	db.insert_row(DECK_TABLE, data)

# TODO
func update_deck_data() -> void:
	pass

func read_data_from_db(table_name: String) -> Dictionary:
	db.open_db()
	var data: Dictionary = db.query("select * from " + table_name + ";")
	return data
