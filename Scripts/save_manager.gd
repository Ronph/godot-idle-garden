extends Node


const save_file_name: String = "res://garden_save.json"
const default_dic: Dictionary = {"gold": 0, "unlocks": ["Sunflower"], "time": 0.0, "basket": 0, "tiles": {}}

func save_game(data: Dictionary):
	var save_file: FileAccess = FileAccess.open(save_file_name, FileAccess.WRITE)
	if save_file == null:
		push_error("Error opening save file for save")
		return
	var string_data: String = JSON.stringify(data)
	save_file.store_line(string_data)
	save_file.close()


func load_game() -> Dictionary:
	if FileAccess.file_exists(save_file_name):
		var save_file: FileAccess = FileAccess.open(save_file_name, FileAccess.READ)
		if save_file == null:
			push_error("Error opening save file for load")
			return default_dic
		
		var json = JSON.new()
		var string_data: String = save_file.get_line()
		if json.parse(string_data) == OK:
			json.parse(string_data)
			var data: Dictionary = json.get_data()
			save_file.close()
			return data
		else:
			push_error("Corrupted save data")
	return default_dic.duplicate(true)

func reset_save():
	save_game(default_dic)
