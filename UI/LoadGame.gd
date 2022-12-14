extends CanvasLayer


var save_files: Array
var player_data: Array

onready var save_1: PanelContainer = $ThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer/SaveFile1
onready var save_2: PanelContainer = $ThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer2/SaveFile2
onready var save_3: PanelContainer = $ThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer3/SaveFile3


func _ready() -> void:
	save_files = [save_1, save_2, save_3]
	player_data = GameDatabase.get_all_data_in_table(GameDatabase.PLAYER_TABLE)
	for save in player_data:
		var index: int = player_data.find(save)
		save_files[index].update_player_data(save["id"], save["name"], save["currency"], save["score"])
		save_files[index].update_labels()


func _on_LoadSaveFile1_pressed() -> void:
	if save_1.active:
		save_1.commit_player_data()
		yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://environment/GameEnvironment.tscn")


func _on_LoadSaveFile2_pressed() -> void:
	if save_2.active:
		save_2.commit_player_data()
		yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://environment/GameEnvironment.tscn")


func _on_LoadSaveFile3_pressed() -> void:
	if save_3.active:
		save_3.commit_player_data()
		yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://environment/GameEnvironment.tscn")
