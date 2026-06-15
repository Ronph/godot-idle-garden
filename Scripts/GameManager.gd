extends Node

signal gained_coins(int)
signal basket_filled(int)
signal state_changed

var coins : int = 100
var unlocked_flowers: Array = ["Sunflower"]
var unlocked_upgrades: Array = []
var harvestSize = 1

var basketSize = 10
var basketCurrent = 0
var moneyInBasket = 0

var tileList = {"null": 0}
var flowerDic = {"Sunflower": [0, 6, 1, 0], #Sunflower, at position 0 in the list, with 5 growth stages, sell price, unlock price
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
			if data.increase_harvest_size > 0:
				harvestSize = data.increase_harvest_size
			if data.increase_basket_size > 0:
				basketSize = data.increase_basket_size
			
			unlocked_upgrades.append(data.display_name)
	print(unlocked_flowers, unlocked_upgrades, "coins: ", coins, ", harvest size: ",harvestSize)
	state_changed.emit()
	return true
		


func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins)
	print(coins)

func fillBasket():
	basketCurrent += 1
	emit_signal("basket_filled", basketCurrent)


func sellBasket():
	gain_coins(moneyInBasket)
	moneyInBasket = 0
	basketCurrent = 0
	emit_signal("basket_filled", basketCurrent)




func get_data() -> Dictionary:
	print("SAVING ", tileList)
	return {"gold": coins, "unlocks": unlocked_flowers, "time": 0, "basket": [basketCurrent, moneyInBasket], "tiles": tileList}


func loadData(coin, unlock, _timeSince, basketFill, tilesList):
	coins = coin
	basketCurrent = int(basketFill[0])
	moneyInBasket = int(basketFill[1])
	tileList = tilesList
	emit_signal("gained_coins", coins)
	emit_signal("basket_filled", basketCurrent)
	unlocked_flowers = unlock
