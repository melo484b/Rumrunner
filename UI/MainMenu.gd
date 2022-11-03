extends CanvasLayer

onready var new_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/NewGame
onready var load_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/LoadGame
onready var options: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Options
onready var quit: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Quit


func _ready():
	new_game.connect("pressed", self, "_on_new_game_button")
	load_game.connect("pressed", self, "_on_load_game_button")
	options.connect("pressed", self, "_on_options_button")
	quit.connect("pressed", self, "_on_quit_button")

func _on_new_game_button() -> void:
	pass
	# get_tree().change_scene("new game scene")

func _on_load_game_button() -> void:
	pass
	# get_tree().change_scene("load game scene")

func _on_options_button() -> void:
	pass

func _on_quit_button() -> void:
	get_tree().quit()
