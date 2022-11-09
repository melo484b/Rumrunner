class_name CardNode
extends Position2D

var selected: bool = false
var filled: bool = false

func _ready() -> void:
	deselect()

func select() -> void:
	modulate = Color.aqua
	selected = true
	filled = true

func deselect() -> void:
	modulate = Color.white
	selected = false
	filled = false

func _on_Area2D_area_exited(_area) -> void:
	deselect()

