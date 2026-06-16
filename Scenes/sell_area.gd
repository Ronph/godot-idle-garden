extends Control



func _can_drop_data(_at_position, data):
	return data is Dictionary and data.get("type") == "basket"
func _drop_data(_at_position, _data):
	GameManager.sellBasket()
