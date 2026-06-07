extends Button


func _on_buy_cabbage_pressed():
	if GameManager.coins >= 5:  # cost to unlock
		GameManager.coins -= 5
		GameManager.current_flower = "Cabbage"
		$CoinsLabel.text = str(GameManager.coins)
