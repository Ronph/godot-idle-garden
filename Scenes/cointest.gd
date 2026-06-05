extends Node

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		GameManager.gain_coins(1)
