extends Card


func _ready() -> void:
	_on_ready()


func drag(state: Physics2DDirectBodyState) -> void:
	var card_transform: Transform2D = get_transform()
	var lerp_to: Vector2 = lerp(global_position, target_position, 10 * state.get_step())
	card_transform.origin.x = lerp_to.x
	card_transform.origin.y = lerp_to.y
	state.set_transform(card_transform)


func _input(_event) -> void:
	pass


func _on_ready() -> void:
	selectable = false
	card_collider.disabled = true
	original_position = global_position
	target_position = global_position


func reset_card() -> void:
	shuffle_sfx.play()
	target_position = original_position
	placed = false
	if visible == false:
		visible = true


func set_placed(node_name: String) -> void:
	var index: int = index_from_node_name(node_name)
	placed = true
	if index != -1:
		emit_signal("placed", card_data, index)
		yield(get_tree().create_timer(0.4), "timeout")
		placement_sfx.play()


func set_card_data(new_data: Dictionary) -> void:
	if !new_data.empty():
		card_data.merge(new_data, true)


func _on_Area2D_input_event(_viewport, _event, _shape_idx) -> void:
	pass
