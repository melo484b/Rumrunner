extends CanvasLayer


signal level_complete
signal player_turn
signal ai_turn

onready var deck: TextureRect = $CardBackTexture
onready var level_progress_bar: MarginContainer = $LevelProgress
onready var incoming_announcement: MarginContainer = $IncomingAnnouncement
onready var turn_timer: MarginContainer = $TurnTimer
onready var input_blocker: Panel = $InputBlocker


func _ready() -> void:
	level_progress_bar.start_level_progress_bar()
	display_incoming_announcement()


func draw_card_animation() -> void:
	deck.draw_animation()


func display_incoming_announcement() -> void:
	input_blocker.visible = true
	incoming_announcement.display_incoming()


func start_player_timer() -> void:
	turn_timer.start_timer()


func _on_ProgressTexture_value_changed(value) -> void:
	if value >= level_progress_bar.MAX_VALUE:
		level_progress_bar.stop()
		emit_signal("level_complete")


func _on_IncomingAnnouncement_incoming() -> void:
	input_blocker.visible = true
	emit_signal("ai_turn")
	


func _on_IncomingAnnouncement_player_turn() -> void:
	input_blocker.visible = false
	start_player_timer()
	emit_signal("player_turn")
