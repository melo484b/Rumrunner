extends CanvasLayer


onready var new_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/NewGame
onready var load_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/LoadGame
onready var options: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Options
onready var quit: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Quit


func _ready() -> void:
# warning-ignore:return_value_discarded
	new_game.connect("pressed", self, "_on_new_game_button")
# warning-ignore:return_value_discarded
	load_game.connect("pressed", self, "_on_load_game_button")
# warning-ignore:return_value_discarded
	options.connect("pressed", self, "_on_options_button")
# warning-ignore:return_value_discarded
	quit.connect("pressed", self, "_on_quit_button")
	pass


func _on_new_game_button() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/NewGame.tscn")


func _on_load_game_button() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/LoadGame.tscn")


func _on_options_button() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/OptionsMenu.tscn")


func _on_quit_button() -> void:
	get_tree().quit()
