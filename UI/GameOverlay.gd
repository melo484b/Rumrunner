extends CanvasLayer


signal level_complete

onready var deck: TextureRect = $CardBackTexture
onready var level_progress_bar: MarginContainer = $LevelProgress
onready var input_blocker: Panel = $InputBlocker


func _ready() -> void:
	level_progress_bar.start_level_progress_bar()


func draw_card_animation() -> void:
	deck.draw_animation()


func toggle_player_input() -> void:
	if input_blocker.visible == true:
		input_blocker.visible = false
	else:
		input_blocker.visible = true


func _on_ProgressTexture_value_changed(value) -> void:
	if value >= level_progress_bar.MAX_VALUE:
		level_progress_bar.stop()
		emit_signal("level_complete")


