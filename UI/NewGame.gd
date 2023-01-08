extends CanvasLayer


const NEW_GAME: bool = true

var save_files: Array
var player_data: Array
var current_save: int
var name_validation = RegEx.new()
var name_is_valid: bool = false

onready var save_1: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer/SaveFile1
onready var save_2: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer2/SaveFile2
onready var save_3: PanelContainer = $SaveThemedMarginContainer/PanelContainer/MarginContainer/HBoxContainer2/VBoxContainer3/SaveFile3
onready var name_line: LineEdit = $NameThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/LineEdit
onready var error_sfx: Node = $ErrorSFXplayer
onready var name_exception: WindowDialog = $NameException


func _ready() -> void:
	save_files = [save_1, save_2, save_3]
	display_player_data_from_database()
	name_validation.compile("^[A-Za-z0-9]+$")


func display_player_data_from_database() -> void:
	player_data = GameDatabase.get_all_data_in_table(GameDatabase.PLAYER_TABLE)
	for save in player_data:
		var index: int = player_data.find(save)
		save_files[index].update_player_data(save["id"], save["name"], save["currency"], save["score"])
		save_files[index].update_labels()
		save_files[index].set_active()


func validate_player_name(name_to_validate: String) -> bool:
	var is_name_valid: RegExMatch = name_validation.search(name_to_validate)
	if is_name_valid:
		return true
	return false


func set_content_error() -> void:
	if name_line.text == "":
		name_exception.show_content_missing_error()
	else:
		name_exception.show_content_error()


func _on_SelectSaveFile1_pressed() -> void:
	if name_is_valid:
		save_1.temp_name = name_line.text
		save_1.check_for_overwrite()
		save_1.set_player_data_to_new_player_data()
		current_save = 0
	else:
		error_sfx.play()
		set_content_error()
		name_exception.popup()


func _on_SelectSaveFile2_pressed() -> void:
	if name_is_valid:
		save_2.check_for_overwrite()
		save_2.set_player_data_to_new_player_data()
		current_save = 1
	else:
		error_sfx.play()
		set_content_error()
		name_exception.popup()
	
	
func _on_SelectSaveFile3_pressed() -> void:
	if name_is_valid:
		save_3.check_for_overwrite()
		save_3.set_player_data_to_new_player_data()
		current_save = 2
	else:
		error_sfx.play()
		set_content_error()
		name_exception.popup()


func _on_ConfirmationButton_pressed() -> void:
	if name_is_valid:
		if save_files[current_save].is_active():
			save_files[current_save].overwrite_player_data()
		else:
			save_files[current_save].write_player_data()
		yield(get_tree().create_timer(0.4), "timeout")
		get_tree().change_scene("res://environment/GameEnvironment.tscn")


func _on_LineEdit_text_changed(new_text):
	name_is_valid = false
	if validate_player_name(new_text):
		name_is_valid = true
