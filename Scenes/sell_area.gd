extends Control


# Called when the node enters the scene tree for the first time.
func _can_drop_data(at_position, data):
	return data is Dictionary and data.get("type") == "basket"
func _drop_data(at_position, data):
	GameManager.sellBasket()
