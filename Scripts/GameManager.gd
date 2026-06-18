extends Node

signal gained_coins(int)
signal basket_filled(index : int, amount: int)
signal state_changed

var has_loaded = false

var coins : int = 100
var unlocked_flowers: Array = ["Sunflower"]
var unlocked_upgrades: Array = []
var harvestSize = 1

var unlockedBaskets = 1
var basketSize = [10, 10, 10, 10]
var basketCurrent = [0, 0, 0, 0]
var moneyInBasket = [0, 0, 0, 0]

var tileList = {"null": 0}
var flowerDic = {"Sunflower": [0, 6, 1, 0], #Sunflower, at position 0 in the list, with 5 growth stages, sell price, unlock price
				 "Cabbage": [1, 4, 2, 5]} 
				
var currentFlower = "Sunflower"


func unlock_flower(flower:String, cost:int):
	if coins >= cost and flower not in unlocked_flowers:
		coins -= cost
		unlocked_flowers.append(flower)	
		
func can_purchase(data: UpgradeData) -> bool:
	return coins >= data.upgrade_cost and unlocked_flowers.size() >= data.has_flowers and data.id not in unlocked_flowers and data.id not in unlocked_upgrades
		
	
func try_purchase(data: UpgradeData):
	if not can_purchase(data):
		return false
	else:
		coins -= data.upgrade_cost
		emit_signal("gained_coins",coins)
		if data.is_flower:
			unlocked_flowers.append(data.id)
		else:
			if data.increase_harvest_size > 0:
				harvestSize = data.increase_harvest_size
			if data.increase_basket_size > 0:
				for i in basketSize.size():
					basketSize[i] = data.increase_basket_size
			
			unlocked_upgrades.append(data.id)
			print("unlocked upgrades: ", unlocked_upgrades)
	#print(unlocked_flowers, unlocked_upgrades, "coins: ", coins, ", harvest size: ",harvestSize)
	state_changed.emit()
	return true
		


func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins)
	#print(coins)
#All things baskets 
func first_open_basket() -> int:
	for i in unlockedBaskets:                 # iterates 0 .. unlockedBaskets-1
		if basketCurrent[i] < basketSize[i]:
			return i
	return -1

func fillBasket(value : int):
	var i = first_open_basket()
	if i == -1:
		return false
	basketCurrent[i] += 1
	moneyInBasket[i] += value
	emit_signal("basket_filled",i, basketCurrent[i])
	return true 


func sellBasket(index : int):
	gain_coins(moneyInBasket[index])
	moneyInBasket[index] = 0
	basketCurrent[index] = 0
	emit_signal("basket_filled", index, 0)
func unlock_basket(cost: int) -> bool:
	if unlockedBaskets >= 4 or coins < cost:
		return false
	coins -= cost
	unlockedBaskets += 1
	emit_signal("gained_coins", coins)
	state_changed.emit()
	return true


#All things saving and stuff
func get_data() -> Dictionary:
	return {
		"gold": coins, "unlockedFlowers": unlocked_flowers, "time": 0,
		"basket": [basketCurrent[0], moneyInBasket[0]],
		"unlocks": unlocked_upgrades,
		"basketCurrent": basketCurrent,
		"moneyInBasket": moneyInBasket,
		"tiles": tileList
	}

func loadData(data: Dictionary):
	coins = data.get("gold", coins)
	unlocked_flowers = data.get("unlockedFlowers", unlocked_flowers)
	tileList = data.get("tiles", {})
	unlocked_upgrades = data.get("unlocks", unlocked_upgrades)

	
	basketSize    = data.get("basketSize", basketSize).duplicate()
	basketCurrent = data.get("basketCurrent", basketCurrent).duplicate()
	moneyInBasket = data.get("moneyInBasket", moneyInBasket).duplicate()

	
	if not data.has("basketCurrent") and data.has("basket"):
		var b = data["basket"]
		if typeof(b) == TYPE_ARRAY and b.size() >= 2:
			basketCurrent[0] = int(b[0])
			moneyInBasket[0] = int(b[1])

	emit_signal("gained_coins", coins)
	for i in basketCurrent.size():
		emit_signal("basket_filled", i, basketCurrent[i])
	
	VARIABLESET()

func VARIABLESET():
	for i in unlocked_upgrades:
		if i[0] == "s":
			if i == "scythe1":
				harvestSize = 5
			if i == "scythe2":
				harvestSize = 9
