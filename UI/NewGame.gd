extends CanvasLayer

signal write_to_slot

onready var save_1: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer/SaveFile1
onready var save_2: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer2/SaveFile2
onready var save_3: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer3/SaveFile3
onready var name_line: LineEdit = $NameThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/LineEdit

var save_files: Array
var player_data: Array
var current_save: int

const NEW_GAME: bool = true

func _ready() -> void:
	save_files = [save_1, save_2, save_3]
	display_player_data_from_database()

func display_player_data_from_database() -> void:
	player_data = GameDatabase.get_all_data_in_table(GameDatabase.PLAYER_TABLE)
	for save in player_data:
		var index: int = player_data.find(save)
		save_files[index].update_player_data(save["id"], save["name"], save["currency"], save["score"])
		save_files[index].update_labels()
		save_files[index].set_active()
	
func _on_SelectSaveFile1_pressed() -> void:
	save_1.temp_name = name_line.text
	save_1.check_for_overwrite()
	save_1.set_player_data_to_new_player_data()
	current_save = 0

func _on_SelectSaveFile2_pressed() -> void:
	save_2.check_for_overwrite()
	save_2.set_player_data_to_new_player_data()
	current_save = 1
	
func _on_SelectSaveFile3_pressed() -> void:
	save_3.check_for_overwrite()
	save_3.set_player_data_to_new_player_data()
	current_save = 2

func _on_ConfirmationButton_pressed():
	if save_files[current_save].is_active():
		save_files[current_save].overwrite_player_data()
	else:
		save_files[current_save].write_player_data()
	get_tree().change_scene("res://environment/GameEnvironment.tscn")
