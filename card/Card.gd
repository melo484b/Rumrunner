class_name Card
extends RigidBody2D


signal placed(card_data, node)

const CARD_CLASS = {
	"cat": "64ff00fb",
	"offense": "64ff0000",
	"defense": "643800ff",
	"strategy": "6400ff0a",
}
const CARD_ART_PATH = "res://card_art/"

export var selectable: bool = true

var card_data: Dictionary
var selected: bool = false
var placed: bool = false
var underway: bool = false
var target_position: Vector2
var original_position: Vector2
var assigned_position: Vector2
var target_nodes: Array = []

onready var collider: CollisionShape2D = $CardCollider
onready var animator: AnimationPlayer = $AnimationPlayer
onready var area: Area2D = $Sprite/Area2D
onready var card_name: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/Name
onready var card_class: PanelContainer = $ThemedMarginContainer/ClassPanelContainer
onready var art: TextureRect = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/TextureRect
onready var description: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/Description
onready var offense: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Offense
onready var defense: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Defense


func _ready() -> void:
	target_nodes = get_tree().get_nodes_in_group("CARD_NODE")
	target_position = global_position
	original_position = global_position
	assigned_position = original_position


func _input(event) -> void:
	if event is InputEventMouseButton and selectable:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			target_position = global_position
			var shortest_distance = 100
			for child in target_nodes:
				if !child.filled and not placed and child.active:
					var distance = global_position.distance_to(child.global_position)
					if distance < shortest_distance:
						child.select()
						target_position = child.global_position
						shortest_distance = distance
						if child.is_in_group("SHIP_NODE"):
							set_placed(child.name)
							child.set_inactive()
						if child.is_in_group("DISCARD"):
							set_placed(child.name)
							animator.play("shrink")


func _integrate_forces(state):
	drag(state)
	if underway:
		state.set_transform(assign_position())


func drag(state: Physics2DDirectBodyState) -> void:
	if selected:
		var card_transform: Transform2D = get_transform()
		var lerp_to: Vector2 = lerp(global_position, get_global_mouse_position(), 25 * state.get_step())
		card_transform.origin.x = lerp_to.x
		card_transform.origin.y = lerp_to.y
		state.set_transform(card_transform)
	elif not selected:
		var card_transform: Transform2D = get_transform()
		var lerp_to: Vector2 = lerp(global_position, target_position, 10 * state.get_step())
		card_transform.origin.x = lerp_to.x
		card_transform.origin.y = lerp_to.y
		state.set_transform(card_transform)


func assign_position() -> Transform2D:
	var card_transform: Transform2D = get_transform()
	card_transform.origin.x = assigned_position.x
	card_transform.origin.y = assigned_position.y
	return card_transform


func set_assigned_position(new_assigned_position: Vector2) -> void:
	assigned_position = new_assigned_position
	

func set_underway(underway_status: bool):
	underway = underway_status


func set_placed(node_name: String) -> void:
	placed = true
	collider.disabled = true
	animator.stop()
	emit_signal("placed", card_data, node_name)
	print(self.name + " placed")


func reset_card() -> void:
	set_underway(true)
	assigned_position = original_position
	placed = false
	collider.disabled = false
	if visible == false:
		visible = true


func set_card_data(new_data: Dictionary) -> void:
	if !new_data.empty():
		card_data.merge(new_data, true)
	else:
		set_placed("none")
		visible = false


func populate_card_data() -> void:
	set_card_name(card_data.get("name", "name err"))
	set_card_class(card_data.get("card_class", "class err"))
	set_card_art(card_data.get("art_id", "art err"))
	set_card_description(card_data.get("description", "desc err"))
	set_card_stats(card_data.get("offensive_stat", -1), card_data.get("defensive_stat", -1))


func set_card_name(card_name: String) -> void:
	self.card_name.text = card_name


func set_card_class(class_modulation: String) -> void:
	card_class.self_modulate = CARD_CLASS.get(class_modulation)


func set_card_art(art_id: int) -> void:
	var art_path: String = CARD_ART_PATH + str(art_id) + ".png"
	art.texture = load(art_path)


func set_card_description(description: String) -> void:
	self.description.text = description


func set_card_stats(offense: int, defense: int) -> void:
	self.offense.text = str(offense)
	self.defense.text = str(defense)


func get_id() -> int:
	return card_data["id"]


func _on_Area2D_input_event(_viewport, _event, _shape_idx) -> void:
	if Input.is_action_just_pressed("left_click") and not placed:
		selected = true
	if selectable:
		underway = false
