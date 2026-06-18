extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.state_changed.connect(add_item_to_dropdown)
	item_selected.connect(_on_option_button_item_selected)
	add_item_to_dropdown()

func add_item_to_dropdown():
	clear()
	for flower in GameManager.unlocked_flowers:
		add_item(flower)
	var idx = GameManager.unlocked_flowers.find(GameManager.currentFlower)
	if idx != -1:
		select(idx)	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_option_button_item_selected(index: int) -> void:
	GameManager.currentFlower = get_item_text(index)
	print("currentFlower is now: ", GameManager.currentFlower)
