extends CanvasLayer


signal start_level
signal level_complete
signal end_player_turn

const INACTIVE_BUTTON: String = "4d5482"
const ACTIVE_BUTTON: String = "ffffff"

onready var deck: TextureRect = $CardBackTexture
onready var level_progress_bar: MarginContainer = $LevelProgress
onready var input_blocker: Panel = $InputBlocker
onready var end_turn_button: Button = $EndTurnButton


func _ready() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	level_progress_bar.start_level_progress_bar()
	emit_signal("start_level")


func draw_card_animation() -> void:
	deck.draw_animation()


func block_player_input():
	input_blocker.visible = true
	end_turn_button.modulate = INACTIVE_BUTTON


func unblock_player_input() -> void:
	input_blocker.visible = false
	end_turn_button.modulate = ACTIVE_BUTTON


func add_progress(progress: int) -> void:
	level_progress_bar.add_progress(progress)


func _on_ProgressTexture_value_changed(value) -> void:
	if value >= level_progress_bar.MAX_VALUE:
		level_progress_bar.stop()
		emit_signal("level_complete")


func _on_EndTurnButton_pressed():
	emit_signal("end_player_turn")
