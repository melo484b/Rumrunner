extends RigidBody2D

class_name Card

onready var collider: CollisionShape2D = $CardCollider
onready var animator: AnimationPlayer = $AnimationPlayer
onready var area: Area2D = $Sprite/Area2D

var selected: bool = false
var placed: bool = false
var target_position: Vector2
var target_nodes: Array = []

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
	placed = true
	collider.disabled = true
	animator.stop()

func reset_card() -> void:
	placed = false
	collider.disabled = false
