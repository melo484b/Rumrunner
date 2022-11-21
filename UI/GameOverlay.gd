extends CanvasLayer


signal start_level
signal level_complete
signal end_player_turn
signal change_scene_to_shop

const INACTIVE_BUTTON: String = "4d5482"
const ACTIVE_BUTTON: String = "ffffff"

onready var deck: TextureRect = $CardBackTexture
onready var level_progress_bar: MarginContainer = $LevelProgress
onready var progress: TextureProgress = $LevelProgress/ProgressTexture
onready var input_blocker: Panel = $InputBlocker
onready var end_turn_button: Button = $EndTurnButton
onready var score_tally: MarginContainer = $ScoreTally


func _ready() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	level_progress_bar.start_level_progress_bar()
	emit_signal("start_level")


func draw_card_animation() -> void:
	deck.draw_animation()


func block_player_input() -> void:
	input_blocker.visible = true
	end_turn_button.modulate = INACTIVE_BUTTON


func unblock_player_input() -> void:
	input_blocker.visible = false
	end_turn_button.modulate = ACTIVE_BUTTON


func add_progress(progress: int) -> void:
	level_progress_bar.add_progress(progress)


func set_score_tally_rum(rum_amount: int) -> void:
	score_tally.set_rum(max(0, rum_amount))


func tally_score() -> void:
	score_tally.calculate_and_tally()


func _on_EndTurnButton_pressed() -> void:
	emit_signal("end_player_turn")


func _on_LevelProgress_progress_complete(level_time) -> void:
	score_tally.set_time(level_time)
	end_turn_button.disabled = true
	end_turn_button.visible = false
	emit_signal("level_complete")


func _on_ScoreTally_continue_button_pressed() -> void:
	emit_signal("change_scene_to_shop")
