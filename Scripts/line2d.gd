extends Line2D

@export var data: UpgradeData
@export var from_button: TextureButton
@export var to_button: TextureButton
# Called when the node enters the scene tree for the first time.
func refresh():
	if GameManager.can_purchase(data):
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(1,1,1,0.4)
func _ready():
	points = [from_button.position + from_button.size / 2,to_button.position + from_button.size]
	print(GameManager.unlocked_flowers)
	GameManager.state_changed.connect(refresh)
	refresh()
