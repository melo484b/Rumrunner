extends CanvasLayer

onready var deck: TextureRect = $CardBackTexture

func _ready():
	pass

func draw_card_animation() -> void:
	deck.draw_animation()
