extends CanvasLayer


signal level_complete

onready var deck: TextureRect = $CardBackTexture
onready var level_progress_bar: MarginContainer = $LevelProgress
onready var incoming_announcement: MarginContainer = $IncomingAnnouncement
onready var turn_timer: MarginContainer = $TurnTimer


func _ready() -> void:
	level_progress_bar.start_level_progress_bar()
	display_incoming_announcement()


func draw_card_animation() -> void:
	deck.draw_animation()


func display_incoming_announcement() -> void:
	incoming_announcement.display_incoming()
	

func _on_ProgressTexture_value_changed(value) -> void:
	if value >= level_progress_bar.MAX_VALUE:
		level_progress_bar.stop()
		emit_signal("level_complete")

func start_player_timer() -> void:
	turn_timer.start_timer()


func _on_IncomingAnnouncement_incoming():
	start_player_timer()
