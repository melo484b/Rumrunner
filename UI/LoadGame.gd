extends CanvasLayer

var player_data: Array

func _ready():
	player_data = GameDatabase.get_all_data_in_table(GameDatabase.PLAYER_TABLE)
	print(player_data)
