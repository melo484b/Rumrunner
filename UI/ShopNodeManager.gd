extends Node


onready var cost_display_1: MarginContainer = $CardCostDisplay
onready var cost_display_2: MarginContainer = $CardCostDisplay2
onready var cost_display_3: MarginContainer = $CardCostDisplay3
onready var cost_display_4: MarginContainer = $CardCostDisplay4
onready var cost_display_5: MarginContainer = $CardCostDisplay5
onready var shop_node_1: Position2D = $ShopNode
onready var shop_node_2: Position2D = $ShopNode2
onready var shop_node_3: Position2D = $ShopNode3
onready var shop_node_4: Position2D = $ShopNode4
onready var shop_node_5: Position2D = $ShopNode5
onready var player_currency: Label = $PlayerCurrencyContainer/PlayerCurrencyDisplay/PanelContainer/MarginContainer/CenterContainer/Label


func _ready() -> void:
	yield(get_tree().root, "ready")
	cost_display_5.set_empty()
	player_currency.text = "Currency: " + str(Player.currency)


# TODO notify player of transaction then change scene
func process_transaction() -> void:
	Player.currency = 10
	if shop_node_5.card_held != null:
		print("purchasing!" + str(shop_node_5.card_held.card_data["name"]))
		if shop_node_5.card_held.card_data["cost"] <= Player.currency:
			Player.currency -= shop_node_5.card_held.card_data["cost"]
			var current_copies: int = GameDatabase.get_current_copies(shop_node_5.card_held.card_data["id"], Player.player_id)
			GameDatabase.associate_new_card_with_player(Player.player_id, shop_node_5.card_held.card_data["id"], current_copies + 1)


func refresh_shop_nodes() -> void:
	var shop_nodes: Array = get_tree().get_nodes_in_group("CARD_NODE")
	for node in shop_nodes:
		if node.filled:
			node.select()


func _on_ShopNode_occupied_by_card(card_data) -> void:
	if !card_data.empty():
		cost_display_1.set_price(card_data["cost"])


func _on_ShopNode2_occupied_by_card(card_data) -> void:
	if !card_data.empty():
		cost_display_2.set_price(card_data["cost"])


func _on_ShopNode3_occupied_by_card(card_data) -> void:
	if !card_data.empty():
		cost_display_3.set_price(card_data["cost"])


func _on_ShopNode4_occupied_by_card(card_data) -> void:
	if !card_data.empty():
		cost_display_4.set_price(card_data["cost"])


func _on_ShopNode5_occupied_by_card(card_data) -> void:
	if !card_data.empty():
		cost_display_5.set_cost(card_data["cost"])


func _on_PurchaseButton_pressed() -> void:
	process_transaction()


func _on_SkipButton_pressed() -> void:
	get_tree().change_scene("res://UI/Interlude.tscn")


func _on_ShopNode_unoccupied() -> void:
	cost_display_1.set_empty()


func _on_ShopNode2_unoccupied() -> void:
	cost_display_2.set_empty()


func _on_ShopNode3_unoccupied() -> void:
	cost_display_3.set_empty()
	
	
func _on_ShopNode4_unoccupied() -> void:
	cost_display_4.set_empty()


func _on_ShopNode5_unoccupied() -> void:
	cost_display_5.set_empty()
