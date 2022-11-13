extends MarginContainer


onready var counter: Label = $PanelContainer/MarginContainer/CenterContainer/ScoreLabel


func set_score_counter_label(new_score: int) -> void:
	counter.text = str(new_score)
