extends CanvasLayer


var options_menu: PackedScene = preload("res://UI/OptionsMenu.tscn")

onready var new_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/NewGame
onready var load_game: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/LoadGame
onready var options: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Options
onready var quit: Button = $ThemedMarginContainer/PanelContainer/MarginContainer/VBoxContainer/Quit
onready var main_menu: MarginContainer = $ThemedMarginContainer


func _ready() -> void:
# warning-ignore:return_value_discarded
	new_game.connect("pressed", self, "_on_new_game_button")
# warning-ignore:return_value_discarded
	load_game.connect("pressed", self, "_on_load_game_button")
# warning-ignore:return_value_discarded
	options.connect("pressed", self, "_on_options_button")
# warning-ignore:return_value_discarded
	quit.connect("pressed", self, "_on_quit_button")


func _on_new_game_button() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/NewGame.tscn")


func _on_load_game_button() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/LoadGame.tscn")


func _on_options_button() -> void:
	var options_menu_instance = options_menu.instance()
	add_child(options_menu_instance)
	main_menu.visible = false
# warning-ignore:return_value_discarded
	options_menu_instance.connect("back_pressed", self, "_on_options_menu_back_pressed")
	


func _on_options_menu_back_pressed() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	main_menu.visible = true
	$OptionsMenu.queue_free()



func _on_quit_button() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	get_tree().quit()
