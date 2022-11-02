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

func add_new_card(name: String, card_class: String, art_id: int, 
description: String, offensive_stat: int, defensive_stat: int, cost: int) -> void:
	db.open_db()
	var data: Dictionary = Dictionary()
	data["name"] = name
	data["card_class"] = card_class
	data["art_id"] = art_id
	data["description"] = description
	data["offensive_stat"] = offensive_stat
	data["defensive_stat"] = defensive_stat
	data["cost"] = cost
	db.insert_row(CARD_TABLE, data)

func associate_new_card_with_player(player_id: int, card_id: int, card_copies: int) -> void:
	db.open_db()
	var data: Dictionary = Dictionary()
	data["player_id"] = player_id
	data["card_id"] = card_id
	data["card_copies"] = card_copies
	db.insert_row(DECK_TABLE, data)

# TODO verify new_value and condition work properly while holding integers OR strings in C# script
func update_data(table_name: String, column_name: String, new_value, condition_column: String, condition) -> void:
	var query: String = str("update " + table_name + " set " + column_name + " = " + new_value + " where " + condition_column + " = " + condition + ";")
	db.open_db()
	db.query(query)

func get_all_data_in_table(table_name: String) -> Array:
	db.open_db()
	db.query("select * from " + table_name + ";")
	var data: Array = db.query_result
	return data

func get_by_id(table_name: String, target_column: String, id: int) -> Array:
	db.open_db()
	db.query("select * from " + table_name + " where " + target_column + " = " + str(id) + ";")
	var data: Array = db.query_result
	return data
