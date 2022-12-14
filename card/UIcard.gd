extends Control


const CARD_CLASS = {
	"cat": "64ff00fb",
	"offense": "64ff0000",
	"defense": "643800ff",
	"strategy": "6400ff0a",
}
const CARD_ART_PATH = "res://card_art/"

var card_data: Dictionary

onready var sprite: Sprite = $Sprite
onready var card_name: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/Name
onready var card_class: PanelContainer = $ThemedMarginContainer/ClassPanelContainer
onready var art: TextureRect = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/TextureRect
onready var description: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/Description
onready var offense: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Offense
onready var defense: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Defense


func set_card_data(new_data: Dictionary) -> void:
	if !new_data.empty():
		card_data.merge(new_data, true)


func populate_card_data() -> void:
	set_card_name(card_data.get("name", "name err"))
	set_card_class(card_data.get("card_class", "cat"))
	set_card_art(card_data.get("art_id", "art err"))
	set_card_description(card_data.get("description", "desc err"))
	set_card_stats(card_data.get("offensive_stat", -1), card_data.get("defensive_stat", -1))
	
	
func set_card_name(new_card_name: String) -> void:
	card_name.text = new_card_name


func set_card_class(class_modulation: String) -> void:
	card_class.self_modulate = CARD_CLASS.get(class_modulation)


func set_card_art(art_id: int) -> void:
	var art_path: String = CARD_ART_PATH + str(art_id) + ".png"
	art.texture = load(art_path)


func set_card_description(new_description: String) -> void:
	description.text = new_description


func set_card_stats(new_offense: int, new_defense: int) -> void:
	offense.text = str(new_offense)
	defense.text = str(new_defense)
