extends Card


func _ready():
	_on_ready()


func drag(state: Physics2DDirectBodyState) -> void:
	var card_transform: Transform2D = get_transform()
	var lerp_to: Vector2 = lerp(global_position, target_position, 10 * state.get_step())
	card_transform.origin.x = lerp_to.x
	card_transform.origin.y = lerp_to.y
	state.set_transform(card_transform)


func _input(event) -> void:
	pass


func _on_ready() -> void:
	selectable = false
	card_collider.disabled = true
	original_position = global_position
	target_position = global_position


func reset_card() -> void:
	print(name + " reset")
	target_position = original_position
	placed = false
	if visible == false:
		visible = true


func set_placed(node_name: String) -> void:
	placed = true
	emit_signal("placed", card_data, node_name)
	print(self.name + " placed")


func set_card_data(new_data: Dictionary) -> void:
	if !new_data.empty():
		card_data.merge(new_data, true)


func _on_Area2D_input_event(_viewport, _event, _shape_idx) -> void:
	pass