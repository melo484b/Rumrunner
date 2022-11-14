extends MarginContainer


onready var counter: Label = $PanelContainer/MarginContainer/CenterContainer/ScoreLabel


func update_score(new_score: int) -> void:
	counter.text = str(new_score)
