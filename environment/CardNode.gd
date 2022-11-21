class_name CardNode
extends Position2D


var selected: bool = false
var filled: bool = false
export var active: bool = true


func _ready() -> void:
	_on_ready()


func _on_ready():
	deselect()


func select() -> void:
	modulate = Color.aqua
	selected = true
	filled = true


func deselect() -> void:
	modulate = Color.white
	selected = false
	filled = false


func set_inactive() -> void:
	active = false


func set_active() -> void:
	active = true


func _on_Area2D_area_exited(_area) -> void:
	deselect()
