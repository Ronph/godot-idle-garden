extends Node2D

@onready var earth: TileMapLayer = $TileMaps/Earth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not GameManager.has_loaded:
		var dict: Dictionary = save_manager.load_game()
		GameManager.loadData(
			dict.get("gold", 0),
			dict.get("unlocks", ["Sunflower"]),
			dict.get("time", 0.0),
			dict.get("basket", [0, 0]),
			dict.get("tiles", {})
		)
		GameManager.has_loaded = true
	earth.startFunc()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _exit_tree() -> void:
	print("SAVING")
	save_manager.save_game(GameManager.get_data())
