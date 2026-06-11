extends Node

signal gained_coins(int)
signal state_changed
var coins : int = 100
var unlocked_flowers: Array = ["Sunflower"]
var unlocked_upgrades: Array = []
var harvestSize = 5
var basketSize = 10
var flowerDic = {"Sunflower": [0, 6, 1, 0], #Sunflower, at position 0 in the list, with 5 growth stages, sell price
				 "Cabbage": [1, 4, 2, 5]} 
				
var currentFlower = "Sunflower"



func unlock_flower(flower:String, cost:int):
	if coins >= cost and flower not in unlocked_flowers:
		coins -= cost
		unlocked_flowers.append(flower)	
		
func can_purchase(data: UpgradeData) -> bool:
	return coins >= data.upgrade_cost and unlocked_flowers.size() >= data.has_flowers and data.display_name not in unlocked_flowers and data.display_name not in unlocked_upgrades
		
	
func try_purchase(data: UpgradeData):
	if not can_purchase(data):
		return false
	else:
		coins -= data.upgrade_cost
		emit_signal("gained_coins",coins)
		if data.is_flower:
			unlocked_flowers.append(data.display_name)
		else:
			harvestSize += data.increase_harvest_size
			basketSize += data.increase_basket_size
			unlocked_upgrades.append(data.display_name)
	print(unlocked_flowers, unlocked_upgrades, coins,harvestSize)
	state_changed.emit()
	return true
		

func loadData(coin, unlock, _timeSince):
	coins = coin
	emit_signal("gained_coins", coins)
	unlocked_flowers = unlock


func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins)
	print(coins)


func get_data() -> Dictionary:
	return {"gold": coins, "unlocks": unlocked_flowers, "time": 0}
