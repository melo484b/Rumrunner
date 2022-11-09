extends CanvasLayer

onready var new_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/NewGame
onready var load_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/LoadGame
onready var options: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Options
onready var quit: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Quit

# TODO investigate error:
# E 0:00:01.952   connect: In Object of type 'PanelContainer': Attempt to connect nonexistent signal 'write_new_file' to method 'PanelContainer._on_SaveFile_write_new_file'.
#  <C++ Error>   Condition "!signal_is_valid" is true. Returned: ERR_INVALID_PARAMETER
#  <C++ Source>  core/object.cpp:1468 @ connect()
#  <Stack Trace> MainMenu.gd:20 @ _on_load_game_button()
func _ready() -> void:
	#new_game.connect("pressed", self, "_on_new_game_button")
	#load_game.connect("pressed", self, "_on_load_game_button")
	#options.connect("pressed", self, "_on_options_button")
	#quit.connect("pressed", self, "_on_quit_button")
	pass

func _on_new_game_button() -> void:
	get_tree().change_scene("res://UI/NewGame.tscn")

func _on_load_game_button() -> void:
	get_tree().change_scene("res://UI/LoadGame.tscn")

func _on_options_button() -> void:
	get_tree().change_scene("res://UI/OptionsMenu.tscn")

func _on_quit_button() -> void:
	get_tree().quit()
