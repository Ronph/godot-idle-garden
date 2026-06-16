extends TextureRect

@export var basket_index: int = 0



func _get_drag_data(_at_position):
	if GameManager.basketCurrent[basket_index] == 0:
		return null
	var preview = TextureRect.new()
	preview.texture = texture
	set_drag_preview(preview)
	return {"type": "basket", "index": basket_index}
