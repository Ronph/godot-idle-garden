extends TileMapLayer

var currentFlower : String:
	get: return GameManager.currentFlower # default flower (we will add code later on to change the current default)

func harvest_flower(tile, flowName, stage, x, y):
	if stage == GameManager.flowerDic[flowName][1] - 1:
		erase_cell(tile)
		GameManager.gain_coins(GameManager.flowerDic[flowName][2])
		return ["", -1, x, y]
	else:
		return [flowName, stage - 1 , x, y]

func place_random_flower(tile, _flowName, _stage, x, y):
	set_cell(tile, GameManager.flowerDic[currentFlower][0], Vector2i(0, 0), 0)
	return [currentFlower, 0, x, y]

func water_random_flower(tile, flowName, stage, x, y):
	if stage < GameManager.flowerDic[flowName][1]:
		set_cell(tile, GameManager.flowerDic[flowName][0], Vector2i(stage, 0), 0)
		return [flowName, stage, x, y]
	else:
		return [flowName, stage - 1, x, y]
