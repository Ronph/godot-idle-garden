extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dict: Dictionary = save_manager.load_game()
	GameManager.loadData(dict["gold"], dict["unlocks"], dict["time"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _exit_tree() -> void:
	print("EXIT")
	save_manager.save_game(GameManager.get_data())
