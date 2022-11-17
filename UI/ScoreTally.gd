extends MarginContainer


signal continue_button_pressed

const MAX_TIME: int = 120

var time: int
var rum: int
var gold: int
var score: int

onready var time_value: Label = $PanelContainer/MarginContainer/VBoxContainer/TimeScore/TimeValue
onready var rum_value: Label = $PanelContainer/MarginContainer/VBoxContainer/RumScore/RumValue
onready var gold_value: Label = $PanelContainer/MarginContainer/VBoxContainer/GoldValueCenterContainer/GoldEarnedValue
onready var score_value: Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreValueCenterContainer/ScoreValue
onready var tween: Tween = $Tween
onready var timer: Timer = $Timer


func set_time(level_time: int) -> void:
	time = level_time


func set_rum(level_rum: int) -> void:
	rum = level_rum


func calculate_and_tally() -> void:
	visible = true
	initialize_scores()
	tally_scores()


func initialize_scores() -> void:
	gold = calculate_gold()
	score = calculate_score()


func calculate_gold() -> int:
	var multiplier: float = max(0.01, 0.03 * (MAX_TIME - time))
	return int(rum * multiplier)


func calculate_score() -> int:
	var multiplier: float = max(0.01, (MAX_TIME - time) * 0.1)
	return int(rum * multiplier)


func tally_scores() -> void:
	count_up_score(time_value, time, 0.5)
	yield(tween, "tween_completed")
	count_up_score(rum_value, rum, 0.5)
	yield(tween, "tween_completed")
	count_up_score(gold_value, gold, 1)
	yield(tween, "tween_completed")
	count_up_score(score_value, score, 1)
	yield(tween, "tween_completed")
	Player.currency += gold
	Player.score += score


func count_up_score(target_label: Label, count_up_to: int, time_to_count: float) -> void:
	tween.interpolate_property(target_label, "text", 0, count_up_to, time_to_count, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func _on_Tween_tween_step(object, _key, _elapsed, value) -> void:
	object.text = str(int(value))


func _on_ContinueButton_pressed():
	emit_signal("continue_button_pressed")
