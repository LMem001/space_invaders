extends Node

const save_file = "user://save_score.dat"
var high_score = 0

func _ready():
	load_score ()

func save_score():
	var file = FileAccess.open("user://save_score.dat", FileAccess.WRITE)
	file.store_string(str(high_score))
	file = null

func load_score():
	var file = FileAccess.open("user://save_score.dat", FileAccess.READ)
	if FileAccess.file_exists(save_file):
		high_score = int(file.get_as_text()) 
