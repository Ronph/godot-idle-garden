extends TileMapLayer

var gridWidth = 25
var gridHeight = 7

var tileDic = {}
var tile

@onready var flowers: TileMapLayer = $"../Flowers"

func _ready():
	# Initialise dictionary for every tile containing current name of flower and growth level
	for x in gridWidth:
		for y in gridHeight:
			tileDic[str(Vector2i(x,y))] = ["", -1]



func _process(delta: float) -> void:
	tile = local_to_map(get_global_mouse_position())
	
	# erase all hover border selection to give the illusion of hovering
	for x in gridWidth:
		for y in gridHeight:
			erase_cell(Vector2(x, y))
	
	# add black border to currently hovered tiles
	if tileDic.has(str(tile)):
		set_cell(tile, 0, Vector2i(0, 0), 0)
		
		if Input.is_action_just_pressed("leftClick"):
			var nameStage = flowers.place_flower(tile, tileDic[str(tile)][0], tileDic[str(tile)][1] + 1)
			tileDic[str(tile)] = nameStage
