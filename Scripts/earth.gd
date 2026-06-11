extends TileMapLayer

var gridWidth = 7
var gridHeight = 7
var startPoint = [10,-3]

var tileDic = {}
var tile

@onready var flowers: TileMapLayer = $"../Flowers"

func _ready():
	for x in gridWidth:
		for y in gridHeight:
			tileDic[str(Vector2i(startPoint[0] + x, startPoint[1] + y))] = ["", -1, startPoint[0] + x, startPoint[1] + y]
	
	reset_tiles()



func _process(_delta: float) -> void:
	tile = local_to_map(get_global_mouse_position())
	
	# erase all hover border selection to give the illusion of hovering
	reset_tiles()
	
	# add black border to currently hovered tiles
	if tileDic.has(str(tile)):
		set_cell(tile, 0, Vector2i(0, 0), 0)
		
		if Input.is_action_just_pressed("leftClick"):
			var flowName = tileDic[str(tile)][0]
			var stage = tileDic[str(tile)][1]
			var flowKey = tileDic.keys()
			
			callHarvest(tile)

			#this is high-key ugly as fuck but idk what else to do lmao
			if  GameManager.harvestSize == 5:
				callHarvest(Vector2i(tile.x-1, tile.y))
				callHarvest(Vector2i(tile.x+1, tile.y))
				callHarvest(Vector2i(tile.x, tile.y-1))
				callHarvest(Vector2i(tile.x, tile.y+1))

func callHarvest(tile):
	if str(tile) in tileDic.keys():
		var flowName = tileDic[str(tile)][0]
		var stage = tileDic[str(tile)][1]
		var x = tileDic[str(tile)][2]
		var y = tileDic[str(tile)][3]
		tileDic[str(tile)] = flowers.harvest_flower(tile, flowName, stage, x, y)
		
func plant():
	var lookingForFree = true
	var dupe = tileDic.duplicate()
	while lookingForFree:
		if len(dupe) == 0:
			lookingForFree = false
			break

		var currTile = dupe.keys().pick_random()
		if tileDic[currTile][0] == "":
			var x = tileDic[currTile][2]
			var y = tileDic[currTile][3]
			var flowName = tileDic[currTile][0]
			var stage = tileDic[currTile][1]+1
			tileDic[currTile] = flowers.place_random_flower(Vector2i(x, y), flowName, stage, x, y)
			lookingForFree = false
		else:
			dupe.erase(currTile)



func water():
	var lookingForFree = true
	var dupe = tileDic.duplicate()
	while lookingForFree:
		if len(dupe) == 0:
			lookingForFree = false
			break

		var currTile = dupe.keys().pick_random()
		if tileDic[currTile][0] != "":
			var x = tileDic[currTile][2]
			var y = tileDic[currTile][3]
			var flowName = tileDic[currTile][0]
			var stage = tileDic[currTile][1]+1
			tileDic[currTile] = flowers.water_random_flower(Vector2i(x, y), flowName, stage, x, y)
			lookingForFree = false
		else:
			dupe.erase(currTile)


func reset_tiles():
	for i in tileDic.keys():
			set_cell(Vector2i(tileDic[i][2], tileDic[i][3]), 1, Vector2i(0, 0), 0)
