class_name Card
extends RigidBody2D

signal placed

const CARD_CLASS = {
	"cat": "64ff00fb",
	"offense": "64ff0000",
	"defense": "643800ff",
	"strategy": "6400ff0a",
}
const CARD_ART_PATH = "res://card_art/"

var card_data: Dictionary
var selected: bool = false
var placed: bool = false
var target_position: Vector2
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
	
func _physics_process(delta) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, target_position, 10 * delta)
		
func _on_Area2D_input_event(_viewport, _event, _shape_idx) -> void:
	if Input.is_action_just_pressed("left_click") and not placed:
		selected = true

func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			target_position = global_position
			var shortest_distance = 150
			for child in target_nodes:
				if !child.filled and not placed:
					var distance = global_position.distance_to(child.global_position)
					if distance < shortest_distance:
						child.select()
						target_position = child.global_position
						shortest_distance = distance
						if child.is_in_group("SHIP_NODE"):
							set_placed()
						if child.is_in_group("DISCARD"):
							set_placed()
							animator.play("shrink")

func set_placed() -> void:
	self.placed = true
	self.collider.disabled = true
	self.animator.stop()
	emit_signal("placed", self.card_data)

func reset_card() -> void:
	self.placed = false
	self.collider.disabled = false
	if self.visible == false:
		self.visible = true

func set_card_data(new_data: Dictionary) -> void:
	if !new_data.empty():
		self.card_data.merge(new_data, true)
	else:
		set_placed()
		self.visible = false
	
func populate_card_data() -> void:
	self.card_name.text = card_data["name"]
	set_card_class(card_data["card_class"])
	set_card_art(card_data["art_id"])
	self.description.text = card_data["description"]
	self.offense.text = str(card_data["offensive_stat"])
	self.defense.text = str(card_data["defensive_stat"])

func set_card_art(art_id: int) -> void:
	var art_path: String = CARD_ART_PATH + str(art_id) + ".png"
	print(art_path)
	art.texture = load(art_path)

func set_card_class(class_modulation: String) -> void:
	card_class.self_modulate = CARD_CLASS.get(class_modulation)
