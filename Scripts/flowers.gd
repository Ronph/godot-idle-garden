extends TileMapLayer

var currentFlower = "Sunflower" # default flower (we will add code later on to change the current default)


# dictionnary containing the name of all our flowers 
# with assinged value a list of their order and max growth, and sell price
var flowerDic = {"Sunflower": [0, 6, 2]} #Sunflower, at position 0 in the list, with 5 growth stages, price


func place_flower(tile, flowName, stage):
	# if there is no name then nothnig is currently planted so we plant our current default flower
	if flowName == "":
		set_cell(tile, flowerDic[currentFlower][0], Vector2i(0, 0), 0)
		return [currentFlower, 0]
	
	
	# if the new stage is under the growth limit proceed --> handle else for selling to erase the cell
	if stage < flowerDic[flowName][1]:
		set_cell(tile, flowerDic[flowName][0], Vector2i(stage, 0), 0)
		return [currentFlower, stage]
	else:
		erase_cell(tile)
		GameManager.gain_coins(flowerDic[name][2])
		return ["", -1]
