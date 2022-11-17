extends MarginContainer


onready var label: Label = $PanelContainer/MarginContainer/CenterContainer/Label


func set_price(price: int) -> void:
	label.text = "Price: " + str(price)


func set_cost(cost: int) -> void:
	label.text = "Cost: " + str(cost)
