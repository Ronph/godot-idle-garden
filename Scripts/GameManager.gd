extends Node

signal gained_coins(int)

var coins : int

func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins)
	print(coins)
