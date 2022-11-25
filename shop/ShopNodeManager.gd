extends Node


signal transaction_made(amount)
signal insufficient_funds

onready var shop_node_1: Position2D = $ShopNode
onready var shop_node_2: Position2D = $ShopNode2
onready var shop_node_3: Position2D = $ShopNode3
onready var shop_node_4: Position2D = $ShopNode4
onready var shop_node_5: Position2D = $ShopNode5
onready var player_currency: CenterContainer = $CurrencyDisplay


func _ready() -> void:
	player_currency.update_label(Player.currency)


# TODO notify player of transaction then change scene
func purchase_card() -> void:
	if shop_node_5.card_held != null:
		print("attempting to purchase: " + str(shop_node_5.card_held.card_data["name"]))
		if shop_node_5.card_held.card_data["cost"] <= Player.currency:
			emit_signal("transaction_made", shop_node_5.card_held.card_data["cost"])
			var current_copies: int = GameDatabase.get_current_copies(shop_node_5.card_held.card_data["id"], Player.player_id)
			GameDatabase.associate_new_card_with_player(Player.player_id, shop_node_5.card_held.card_data["id"], current_copies + 1)
		else:
			emit_signal("insufficient_funds")

func refresh_shop_nodes() -> void:
	var shop_nodes: Array = get_tree().get_nodes_in_group("CARD_NODE")
	for node in shop_nodes:
		node.select()


func _on_PurchaseButton_pressed() -> void:
	purchase_card()


func _on_SkipButton_pressed() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/Interlude.tscn")
