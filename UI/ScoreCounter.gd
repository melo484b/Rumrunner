extends MarginContainer


onready var counter: Label = $PanelContainer/MarginContainer/CenterContainer/ScoreLabel
onready var rum_splash: Particles2D = $RumSplash
onready var animator: AnimationPlayer = $AnimationPlayer
onready var slosh_sfx: Node = $SloshSFXplayer
onready var damage_sfx: Node = $DamageSFXplayer


func update_score(new_score: int) -> void:
	if int(counter.text) > new_score:
		damage_sfx.play()
		animator.play("lose_rum")
	elif int(counter.text) < new_score:
		animator.play("gain_rum")
	else:
		animator.play("no_change")
	slosh_sfx.play()
	counter.text = str(new_score)
	rum_splash.restart()
