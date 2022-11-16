class_name Card
extends RigidBody2D


signal placed(card_data, index)

const CARD_CLASS = {
	"cat": "64ff00fb",
	"offense": "64ff0000",
	"defense": "643800ff",
	"strategy": "6400ff0a",
}
const CARD_ART_PATH = "res://card_art/"

var selectable: bool = true
var card_data: Dictionary
var selected: bool = false
var placed: bool = false
var underway: bool = false
var target_position: Vector2
var original_position: Vector2
var target_nodes: Array = []

onready var card_collider: CollisionShape2D = $CardCollider
onready var animator: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $Sprite
onready var area: Area2D = $Sprite/Area2D
onready var card_name: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/Name
onready var card_class: PanelContainer = $ThemedMarginContainer/ClassPanelContainer
onready var art: TextureRect = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/TextureRect
onready var description: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/Description
onready var offense: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Offense
onready var defense: Label = $ThemedMarginContainer/ClassPanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Defense


func _ready() -> void:
	_on_ready()


func _on_ready() -> void:
	target_nodes = get_tree().get_nodes_in_group("CARD_NODE")
	target_position = global_position
	original_position = global_position


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


func set_target_position(new_target_position: Vector2) -> void:
	target_position = new_target_position


func set_placed(node_name: String) -> void:
	var index: int = index_from_node_name(node_name)
	placed = true
	card_collider.disabled = true
	animator.stop()
	if index != -1:
		emit_signal("placed", card_data, index)


func index_from_node_name(name_in: String) -> int:
	match name_in:
		"bow":
			return 0
		"port":
			return 1
		"starboard":
			return 2
		"stern":
			return 3
		_:
			return -1


func reset_card() -> void:
	target_position = original_position
	placed = false
	if visible == false:
		visible = true
	yield(get_tree().create_timer(0.2), "timeout")
	card_collider.disabled = false
	if sprite.scale == Vector2(0.25, 0.25):
		animator.play("grow")

func set_card_data(new_data: Dictionary) -> void:
	if !new_data.empty():
		card_data.merge(new_data, true)
	else:
		visible = false


func populate_card_data() -> void:
	set_card_name(card_data.get("name", "name err"))
	set_card_class(card_data.get("card_class", "class err"))
	set_card_art(card_data.get("art_id", "art err"))
	set_card_description(card_data.get("description", "desc err"))
	set_card_stats(card_data.get("offensive_stat", -1), card_data.get("defensive_stat", -1))


func spin() -> void:
	animator.play("spin")


func set_card_name(new_card_name: String) -> void:
	card_name.text = new_card_name


func set_card_class(class_modulation: String) -> void:
	card_class.self_modulate = CARD_CLASS.get(class_modulation)


func set_card_art(art_id: int) -> void:
	var art_path: String = CARD_ART_PATH + str(art_id) + ".png"
	art.texture = load(art_path)


func set_card_description(new_description: String) -> void:
	description.text = new_description


func set_card_stats(new_offense: int, new_defense: int) -> void:
	offense.text = str(new_offense)
	defense.text = str(new_defense)


func get_id() -> int:
	return card_data["id"]


func _on_Area2D_input_event(_viewport, _event, _shape_idx) -> void:
	if Input.is_action_just_pressed("left_click") and not placed:
		selected = true
