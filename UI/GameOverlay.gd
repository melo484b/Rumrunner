extends CanvasLayer

onready var deck: TextureRect = $CardBackTexture

func _ready() -> void:
	pass

func draw_card_animation() -> void:
	deck.draw_animation()
