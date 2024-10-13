extends Node

const SAVE_FILE = "user://gamesave.save"

var high_score = 0
var total_score = 0
var total_flap = 0
var total_run = 0


func _ready() -> void:
	load_game()


func save():
	var save_dict = {
		"high_score": high_score,
		"total_score": total_score,
		"total_flap": total_flap,
		"total_run": total_run
	}
	return save_dict


func save_game():
	var game_save = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	
	var json_string = JSON.stringify(save())
	
	game_save.store_line(json_string)


func load_game():
	if not FileAccess.file_exists(SAVE_FILE):
		return
	
	var game_save = FileAccess.open(SAVE_FILE, FileAccess.READ)
	
	while game_save.get_position() < game_save.get_length():
		var json_string = game_save.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		high_score = node_data["high_score"]
		total_score = node_data["total_score"]
		total_flap = node_data["total_flap"]
		total_run = node_data["total_run"]
