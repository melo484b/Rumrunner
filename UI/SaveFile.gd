extends PanelContainer


const HOVERED_MODULATE: String = "00ffe6"
const NORMAL_MODULATE: String = "ffffff"
const DEACTIVATED_MODULATE: String = "111111"
const LOADED_MODULATE: String = "1a0095"
const UNSAVED_FILE_NAMES: Array = ["[Slot 1]", "[Slot 2]", "[Slot 3]", "Player Name"]

export var exported_player_id: int = 1

var active: bool = false
var selected: bool = false
var new_game: bool
var temp_name: String = ""
var save_data: Dictionary = {
	"player_id": -1,
	"player_name": "Player Name",
	"currency": 0,
	"score": 0
}

onready var player_name: Label = $VBoxContainer2/PlayerName
onready var currency: Label = $VBoxContainer2/Currency
onready var score: Label = $VBoxContainer2/Score
onready var confirmation: ConfirmationDialog = $ConfirmationDialog


func _ready() -> void:
	set_inactive()
	initialize_player_id()


func initialize_player_id() -> void:
	save_data["player_id"] = exported_player_id


func set_player_data_to_new_player_data() -> void:
	save_data["player_name"] = self.temp_name
	save_data["currency"] = 0
	save_data["score"] = 0


func update_player_data(new_id: int, new_name: String, new_currency: int, new_score: int) -> void:
	save_data["player_id"] = new_id
	save_data["player_name"] = new_name
	save_data["currency"] = new_currency
	save_data["score"] = new_score


func update_labels() -> void:
	player_name.text = save_data["player_name"]
	currency.text = "$" + str(save_data["currency"])
	score.text = str(save_data["score"])
	if UNSAVED_FILE_NAMES.has(save_data["player_name"]):
		set_inactive()
	else:
		set_active()


func set_inactive() -> void:
	active = false
	modulate = DEACTIVATED_MODULATE


func set_active() -> void:
	active = true
	modulate = NORMAL_MODULATE


func is_active() -> bool:
	return self.active


func commit_player_data() -> void:
	Player.player_id = save_data["player_id"]
	Player.player_name = save_data["player_name"]
	Player.currency = save_data["currency"]
	Player.score = save_data["score"]


func write_to_slot() -> void:
	commit_player_data()
	write_player_data()


func overwrite_slot() -> void:
	commit_player_data()
	overwrite_player_data()


func check_for_overwrite() -> void:
	if is_active():
		confirmation.popup_centered()


func overwrite_player_data() -> void:
	GameDatabase.update_player_data(save_data["player_id"], save_data["player_name"], save_data["currency"], save_data["score"])


func write_player_data() -> void:
	GameDatabase.add_new_player(save_data["player_name"], save_data["currency"], save_data["score"])


func check_new_game() -> void:
	if (self.new_game):
		set_player_data_to_new_player_data()


func set_new_game(is_new_game: bool):
	self.new_game = is_new_game


func show_file_loaded() -> void:
	self_modulate = LOADED_MODULATE


func show_file_not_loaded() -> void:
	self_modulate = NORMAL_MODULATE


func _on_SaveFile_mouse_entered() -> void:
	if active:
		modulate = HOVERED_MODULATE


func _on_SaveFile_mouse_exited() -> void:
	if active:
		modulate = NORMAL_MODULATE


func _on_ConfirmationDialog_confirmed() -> void:
	commit_player_data()
	update_labels()
