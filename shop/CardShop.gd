extends CanvasLayer


var reroll_cost: int = 2
var reroll_cost_as_float: float = 0.0

onready var reroll_cost_display: MarginContainer = $ShopNodeManager/RerollCostDisplay
onready var shop_node_manager: Node = $ShopNodeManager
onready var dice: Sprite = $ShopNodeManager/Dice
onready var shop_card_manager: Node = $ShopCardManager
onready var currency_display: CenterContainer = $ShopNodeManager/CurrencyDisplay
onready var shop_sfx: Node = $ShopSFXplayer
onready var error_sfx: Node = $ErrorSFXplayer


func _ready() -> void:
	currency_display.update_label(Player.currency)
	GameDatabase.update_player_data(Player.player_id, Player.name, Player.currency, Player.score)


func increase_cost() -> void:
	reroll_cost = int(reroll_cost * 1.6175)


func process_transaction(transaction_amount) -> void:
# warning-ignore:narrowing_conversion
	Player.currency = int(max(0, Player.currency - transaction_amount))
	currency_display.update_label(Player.currency)
	GameDatabase.update_player_data(Player.player_id, Player.name, Player.currency, Player.score)
	yield(get_tree().create_timer(0.1), "timeout")
	shop_sfx.play()


func _on_RerollButton_pressed() -> void:
	if Player.currency >= reroll_cost:
		increase_cost()
		reroll_cost_display.set_cost(reroll_cost)
		dice.roll_the_die()
		shop_card_manager.discard_hand()
		shop_card_manager.draw_hand()
		shop_node_manager.refresh_shop_nodes()
		process_transaction(reroll_cost)
	else:
		yield(get_tree().create_timer(0.1), "timeout")
		error_sfx.play()


func _on_ShopNodeManager_transaction_made(amount):
	process_transaction(amount)


func _on_ShopNodeManager_insufficient_funds():
	yield(get_tree().create_timer(0.1), "timeout")
	error_sfx.play()
