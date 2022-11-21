extends CanvasLayer


var reroll_cost: int = 2
var reroll_cost_as_float: float = 0.0

onready var reroll_cost_display: MarginContainer = $ShopNodeManager/RerollCostDisplay
onready var shop_node_manager: Node = $ShopNodeManager
onready var dice: Sprite = $ShopNodeManager/Dice
onready var shop_card_manager: Node = $ShopCardManager


func increase_cost() -> void:
	reroll_cost = int(reroll_cost * 1.6175)


func _on_RerollButton_pressed():
	if Player.currency > reroll_cost:
		increase_cost()
		reroll_cost_display.set_cost(reroll_cost)
		shop_node_manager.refresh_shop_nodes()
		dice.roll_the_die()
		shop_card_manager.discard_hand()
		shop_card_manager.draw_hand()
	else:
		pass
		# TODO: Warn player they do not have enough money
