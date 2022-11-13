extends CanvasLayer


signal level_complete
signal end_player_turn


onready var deck: TextureRect = $CardBackTexture
onready var level_progress_bar: MarginContainer = $LevelProgress
onready var input_blocker: Panel = $InputBlocker


func _ready() -> void:
	level_progress_bar.start_level_progress_bar()


func draw_card_animation() -> void:
	deck.draw_animation()


func block_player_input():
	input_blocker.visible = true
	


func unblock_player_input() -> void:
	input_blocker.visible = false


func add_progress(progress: int) -> void:
	level_progress_bar.add_progress(progress)


func _on_ProgressTexture_value_changed(value) -> void:
	if value >= level_progress_bar.MAX_VALUE:
		level_progress_bar.stop()
		emit_signal("level_complete")


func _on_GameButton_pressed():
	emit_signal("end_player_turn")
