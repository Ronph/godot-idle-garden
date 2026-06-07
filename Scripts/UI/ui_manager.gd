extends CanvasLayer

func _ready():
	GameManager.gained_coins.connect(update_coin_display)
	$ShopPanel.hide()
func update_coin_display(total):
	$CoinCount.text = str(total)
func _on_shop_button_pressed():
	$ShopPanel.visible = !$ShopPanel.visible

func _on_sunflower_button_pressed():
	GameManager.currentFlower = "SunFlower"	

#Check if there is  enough money, deducts it then sets cabbage as current flower and keeps it unlocked.
#You can switch back by pressing the sunflower button. Its defualt flower so doesnt need to be unlocked
func _on_cabbage_button_pressed():
	if GameManager.coins >= 5:
		GameManager.coins -= 5
		GameManager.currentFlower = "Cabbage"
		GameManager.unlocked_flowers.append("Cabbage")
		update_coin_display(GameManager.coins)
