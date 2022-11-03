extends CanvasLayer

onready var save_1: PanelContainer = $ThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer/SaveFile1
onready var save_2: PanelContainer = $ThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer2/SaveFile2
onready var save_3: PanelContainer = $ThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer3/SaveFile3

var save_files: Array
var player_data: Array

func _ready():
	save_files = [save_1, save_2, save_3]
	player_data = GameDatabase.get_all_data_in_table(GameDatabase.PLAYER_TABLE)
	for save in player_data:
		var index: int = player_data.find(save)
		save_files[index].update_player_data(save["id"], save["name"], save["currency"], save["score"])
		save_files[index].update_labels()
		save_files[index].set_active()

func _on_LoadSaveFile1_pressed():
	save_1.commit_player_data()

func _on_LoadSaveFile2_pressed():
	save_2.commit_player_data()

func _on_LoadSaveFile3_pressed():
	save_3.commit_player_data()
