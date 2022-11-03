extends PanelContainer

onready var player_name: Label = $VBoxContainer2/PlayerName
onready var currency: Label = $VBoxContainer2/Currency
onready var score: Label = $VBoxContainer2/Score

const HOVERED_MODULATE = "00ffe6"
const NORMAL_MODULATE = "ffffff"
const DEACTIVATED_MODULATE = "111111"

var active: bool = false
var selected: bool = false

var save_data: Dictionary = {
	"player_id": 1,
	"player_name": "Player Name",
	"currency": 99,
	"score": 200
}

func _ready():
	set_inactive()

func _on_SaveFile_mouse_entered():
	if active:
		modulate = HOVERED_MODULATE

func _on_SaveFile_mouse_exited():
	if active:
		modulate = NORMAL_MODULATE


func update_player_data(new_id: int, new_name: String, new_currency: int, new_score: int) -> void:
	save_data["player_id"] = new_id
	save_data["player_name"] = new_name
	save_data["currency"] = new_currency
	save_data["score"] = new_score

func update_labels() -> void:
	player_name.text = save_data["player_name"]
	currency.text = "$" + str(save_data["currency"])
	score.text = str(save_data["score"])

func set_inactive() -> void:
	active = false
	modulate = DEACTIVATED_MODULATE

func set_active() -> void:
	active = true
	modulate = NORMAL_MODULATE

func commit_player_data():
	Player.player_id = save_data["player_id"]
	Player.player_name = save_data["player_name"]
	Player.currency = save_data["currency"]
	Player.score = save_data["score"]
	print(Player.player_id)
	print(Player.player_name)
	print(Player.currency)
	print(Player.score)
