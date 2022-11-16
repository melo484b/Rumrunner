class_name ShipNodeManager
extends Node


func reset_ship_nodes():
	var children: Array = get_children()
	for child in children:
		child.deselect()
		child.set_active()


func _on_CardManager_player_hand_discarded():
	reset_ship_nodes()


func _on_GameOverlay_level_complete():
	var children: Array = get_children()
	for child in children:
		child.visible = false
		child.set_inactive()
