extends MarginContainer


export var initial_label_text: String = "-"

onready var label: Label = $PanelContainer/MarginContainer/CenterContainer/Label


func _ready() -> void:
	label.text = initial_label_text


func set_price(price: int) -> void:
	label.text = "Price: " + str(price)


func set_cost(cost: int) -> void:
	label.text = "Cost: " + str(cost)


func set_empty() -> void:
	label.text = initial_label_text
