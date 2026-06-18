extends Node2D
@onready var earth: TileMapLayer = $TileMaps/Earth

func _ready() -> void:
	if not GameManager.has_loaded:
		var dict: Dictionary = save_manager.load_game()
		GameManager.loadData(dict)
		GameManager.has_loaded = true
	earth.startFunc()

func _process(_delta: float) -> void:
	pass

func _exit_tree() -> void:
	print("SAVING")
	save_manager.save_game(GameManager.get_data())
