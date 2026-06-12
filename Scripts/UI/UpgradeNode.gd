extends TextureButton
@export var data: UpgradeData

# Called when the node enters the scene tree for the first time.
func refresh():
	if GameManager.can_purchase(data):
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(1,1,1,0.4)
func _ready():
	tooltip_text = "%s\n%s\nCost: %d" % [data.display_name, data.description, data.upgrade_cost]
	print(GameManager.unlocked_flowers)
	texture_normal = data.icon
	GameManager.state_changed.connect(refresh)
	refresh()
	
func _on_pressed():
	GameManager.try_purchase(data)
