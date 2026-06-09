extends CanvasLayer

@onready var earth: TileMapLayer = $"../TileMaps/Earth"

func _ready():
	GameManager.gained_coins.connect(update_coin_display)


func update_coin_display(total):
	$CoinCount.text = str(total)


func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/shop.tscn")



func _on_plant_button_pressed() -> void:
	earth.plant()


func _on_water_button_pressed() -> void:
	earth.water()
