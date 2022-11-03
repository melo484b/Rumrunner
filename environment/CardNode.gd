extends Position2D
class_name CardNode

var selected: bool = false
var filled: bool = false

func _ready():
	select()

func select():
	modulate = Color.aqua
	selected = true
	filled = true

func deselect():
	modulate = Color.white
	selected = false
	filled = false

func _on_Area2D_area_exited(_area):
	deselect()

