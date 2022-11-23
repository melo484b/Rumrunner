extends CenterContainer


onready var label: Label = $PlayerCurrencyDisplay/PanelContainer/MarginContainer/CenterContainer/Label


func update_label(player_currency: int) -> void:
	label.text = "Dough: $" + str(player_currency)
