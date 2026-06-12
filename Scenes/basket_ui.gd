extends TextureRect


func _get_drag_data(at_position):
	if GameManager.basketCurrent == 0:
		return null
	var preview = TextureRect.new()
	preview.texture = texture
	set_drag_preview(preview)
	return {"type": "basket"}
