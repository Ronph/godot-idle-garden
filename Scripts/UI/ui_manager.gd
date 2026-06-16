extends CanvasLayer

@onready var earth: TileMapLayer = $"../TileMaps/Earth"

func _ready():
	GameManager.gained_coins.connect(update_coin_display)
	GameManager.basket_filled.connect(update_basket_display)


func update_coin_display(total):
	$CoinCount.text = str(total)

func update_basket_display(index, total):
	if GameManager.basketCurrent[index] < GameManager.basketSize[index]:
		$BasketCount.text = "Basket: " + str(total)
	else:
		$BasketCount.text = "Basket: FULL"

func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/upgrade_scene.tscn")



func _on_plant_button_pressed() -> void:
	earth.plant()


func _on_water_button_pressed() -> void:
	earth.water()


func _on_sell_button_pressed() -> void:
	GameManager.sellBasket(0)
