class_name CardRecord
extends MarginContainer


onready var id_label: Label = $PanelContainer/MarginContainer/AttributeLabels/id
onready var name_label: Label = $PanelContainer/MarginContainer/AttributeLabels/name
onready var class_label: Label = $PanelContainer/MarginContainer/AttributeLabels/card_class
onready var art_label: Label = $PanelContainer/MarginContainer/AttributeLabels/art_id
onready var description_label: Label = $PanelContainer/MarginContainer/AttributeLabels/description
onready var offense_label: Label = $PanelContainer/MarginContainer/AttributeLabels/offensive_stat
onready var defense_label: Label = $PanelContainer/MarginContainer/AttributeLabels/defensive_stat
onready var cost_label: Label = $PanelContainer/MarginContainer/AttributeLabels/cost


func set_record_data(id: String, card_name: String, card_class: String, art_id: String, description: String, offense: String, defense: String, cost: String) -> void:
	id_label.text = id
	name_label.text = card_name
	class_label.text = card_class
	art_label.text = art_id
	description_label.text = description
	offense_label.text = offense
	defense_label.text = defense
	cost_label.text = cost


func get_record_data() -> Array:
	return [id_label.text, name_label.text, class_label.text, art_label.text, description_label.text, offense_label.text, defense_label.text, cost_label.text]
