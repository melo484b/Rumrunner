extends "res://addons/gut/test.gd"


var card_node: GDScript = load("res://environment/CardNode.gd")
var _node = null


func before_each() -> void:
	_node = card_node.new()
	

func after_each() -> void:
	_node.free()


func test_on_ready() -> void:
	test_deselect()


func test_select() -> void:
	_node.select()
	assert_true(_node.modulate == Color.aqua, "modulate should be aqua: " + str(_node.modulate))
	assert_true(_node.selected == true, "selected should equal true: " + str(_node.selected))
	assert_true(_node.filled == true, "filled should be set to true: " + str(_node.filled))
	

func test_deselect() -> void:
	_node.deselect()
	assert_true(_node.modulate == Color.white, "modulate should be white: " + str(_node.modulate))
	assert_true(_node.selected == false, "selected should equal false: " + str(_node.selected))
	assert_true(_node.filled == false, "filled should be set to false: " + str(_node.filled))


func test_set_inactive() -> void:
	_node.set_inactive()
	assert_true(_node.active == false, "active should be false: " + str(_node.active))


func test_set_active() -> void:
	_node.set_active()
	assert_true(_node.active == true, "active should be true: " + str(_node.active))
