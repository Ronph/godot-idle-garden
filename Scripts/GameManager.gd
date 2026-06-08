extends Node

signal gained_coins(int)

var coins : int
var unlocked_flowers: Array = ["Sunflower"]

var flowerDic = {"SunFlower": [0, 6, 1, 0], #Sunflower, at position 0 in the list, with 5 growth stages, sell price
				 "Cabbage": [1, 4, 2, 5]} 
				
var currentFlower = "SunFlower"
func unlock_flower(flower:String, cost:int):
	if coins >= cost and flower not in unlocked_flowers:
		coins -= cost
		unlocked_flowers.append(flower)


func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins)
	print(coins)
