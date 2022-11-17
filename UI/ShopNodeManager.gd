extends Node


onready var cost_display_1: MarginContainer = $CardCostDisplay
onready var cost_display_2: MarginContainer = $CardCostDisplay2
onready var cost_display_3: MarginContainer = $CardCostDisplay3
onready var cost_display_4: MarginContainer = $CardCostDisplay4
onready var cost_display_5: MarginContainer = $CardCostDisplay5
onready var player_currency: Label = $PlayerCurrencyContainer/PlayerCurrencyDisplay/PanelContainer/MarginContainer/CenterContainer/Label


func _ready():
	player_currency.text = "Currency: " + str(Player.currency)


func process_transaction() -> void:
	pass


func _on_ShopNode_occupied_by_card(card_data):
	if !card_data.empty():
		cost_display_1.set_price(card_data["cost"])


func _on_ShopNode2_occupied_by_card(card_data):
	if !card_data.empty():
		cost_display_2.set_price(card_data["cost"])


func _on_ShopNode3_occupied_by_card(card_data):
	if !card_data.empty():
		cost_display_3.set_price(card_data["cost"])


func _on_ShopNode4_occupied_by_card(card_data):
	if !card_data.empty():
		cost_display_4.set_price(card_data["cost"])


func _on_ShopNode5_occupied_by_card(card_data):
	if !card_data.empty():
		cost_display_5.set_cost(card_data["cost"])


func _on_PurchaseButton_pressed():
	process_transaction()
