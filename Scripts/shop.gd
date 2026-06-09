extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gained_coins.connect(update_coin_display)
	update_coin_display(GameManager.coins)
	refresh_shop()

func update_coin_display(total):
	$VBoxContainer/CoinCount.text = str(total)


func _on_returnShop_button_pressed():
	save_manager.save_game(GameManager.get_data())
	get_tree().change_scene_to_file("res://Scenes/Garden.tscn")


func refresh_shop():
	for flower in GameManager.flowerDic:
		update_button(flower, flower, GameManager.flowerDic[flower][3])


#This is just place holder updates
func update_button(buttonName, flowerKey, cost):
	var button = $VBoxContainer.get_node(buttonName)
	var owned = flowerKey in GameManager.unlocked_flowers
	var equipped = GameManager.currentFlower == flowerKey
	
	if equipped:
		button.text = flowerKey + " [Equipped]"
	elif owned:
		button.text = flowerKey + " [Select]"
	else:
		button.text = flowerKey + " " + str(cost)	
	button.disabled = not owned and GameManager.coins < cost


func _on_sunflower_button_pressed():
	GameManager.currentFlower = "Sunflower"
	refresh_shop()


func _on_cabbage_button_pressed():
	GameManager.currentFlower = "Cabbage"
	if "Cabbage" not in GameManager.unlocked_flowers:
		GameManager.gain_coins(-5)
		GameManager.unlocked_flowers.append("Cabbage")
	GameManager.currentFlower = "Cabbage"
	refresh_shop()
