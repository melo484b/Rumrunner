extends CanvasLayer

onready var save_1: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer/SaveFile1
onready var save_2: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer2/SaveFile2
onready var save_3: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer3/SaveFile3
onready var name_line: LineEdit = $NameThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/LineEdit

var save_files: Array
var player_data: Array

func _ready() -> void:
	save_files = [save_1, save_2, save_3]
	update_player_data()

func update_player_data() -> void:
	player_data = GameDatabase.get_all_data_in_table(GameDatabase.PLAYER_TABLE)
	for save in player_data:
		var index: int = player_data.find(save)
		save_files[index].update_player_data(save["id"], save["name"], save["currency"], save["score"])
		save_files[index].update_labels()
		save_files[index].set_active()
	
func _on_SelectSaveFile1_pressed() -> void:
	save_1.temp_name = name_line.text
	save_1.write_to_slot(true)
	save_1.commit_player_data()
	get_tree().change_scene("res://environment/GameEnvironment.tscn")

func _on_SelectSaveFile2_pressed() -> void:
	save_2.temp_name = name_line.text
	save_2.write_to_slot(true)
	save_2.commit_player_data()
	get_tree().change_scene("res://environment/GameEnvironment.tscn")
	
func _on_SelectSaveFile3_pressed() -> void:
	save_3.temp_name = name_line.text
	save_3.write_to_slot(true)
	save_3.commit_player_data()
	get_tree().change_scene("res://environment/GameEnvironment.tscn")
