extends TileMapLayer

var gridWidth = 7
var gridHeight = 5
var startPoint = [8,1]

var tileDic = {}
var tile

@onready var flowers: TileMapLayer = $"../Flowers"

func _ready():
	# Initialise dictionary for every tile containing current name of flower and growth level
	#for y in gridWidth:
	#	for x in gridHeight:
	#		tileDic[str(Vector2i(x,y))] = ["", -1]
	var x = 0
	var y = 0
	var itterations
	
	# Initialise the first half of the tiles
	for i in range(1, gridWidth + 1):
		itterations = i + (i-1)
		if itterations > (1 + (gridHeight-1) * 2):
			itterations = 1 + (gridHeight-1) * 2
		
		x = startPoint[0] + (i - 1)
		y = startPoint[1] - (i-1)
		
		for j in itterations:
			tileDic[str(Vector2i(x, y + j))] = ["", -1, x, y + j]
	
	# Initialise the second half of the tiles
	for i in range(x + 1, x + gridHeight):
		itterations = itterations - 2
		y = y + 1
		for j in itterations:
			tileDic[str(Vector2i(i, y + j))] = ["", -1, i, y + j]
	
	
	reset_tiles()



func _process(_delta: float) -> void:
	tile = local_to_map(get_global_mouse_position())
	
	# erase all hover border selection to give the illusion of hovering
	reset_tiles()
	
	# add black border to currently hovered tiles
	if tileDic.has(str(tile)):
		set_cell(tile, 0, Vector2i(0, 0), 0)
		
		if Input.is_action_just_pressed("leftClick"):
			var nameStage = flowers.place_flower(tile, tileDic[str(tile)][0], tileDic[str(tile)][1] + 1, tileDic[str(tile)][2], tileDic[str(tile)][3])
			tileDic[str(tile)] = nameStage


func reset_tiles():
	for i in tileDic.keys():
			set_cell(Vector2i(tileDic[i][2], tileDic[i][3]), 1, Vector2i(0, 0), 0)
