class_name CardNode
extends Position2D


var selected: bool = false
var filled: bool = false
export var active: bool = true


func _ready() -> void:
	deselect()


func select() -> void:
	modulate = Color.aqua
	self.selected = true
	self.filled = true


func deselect() -> void:
	modulate = Color.white
	self.selected = false
	self.filled = false


func set_inactive() -> void:
	self.active = false


func set_active() -> void:
	self.active = true


func _on_Area2D_area_exited(_area) -> void:
	deselect()
