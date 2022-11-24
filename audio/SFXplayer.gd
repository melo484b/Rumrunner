extends Node


export (int) var number_to_play = 2
export (bool) var pitch_randomization_enabled = true
export (float) var min_pitch_scale = 0.9
export (float) var max_pitch_scale = 1.1

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()


func play() -> void:
	var playable: Array = []
	for stream_player in get_children():
		if !stream_player.playing:
			playable.append(stream_player)

	for i in number_to_play:
		if playable.size() == 0:
			break
		var index = rng.randi_range(0, playable.size() - 1)
		
		if pitch_randomization_enabled:
			playable[index].pitch_scale = rng.randf_range(min_pitch_scale, max_pitch_scale)
		
		playable[index].play()
		playable.remove(index)


func play_hover() -> void:
# warning-ignore:return_value_discarded
	get_children()
