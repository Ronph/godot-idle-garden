extends TextureButton
@export var data: UpgradeData

# Called when the node enters the scene tree for the first time.
func _ready():
	print(GameManager.unlocked_flowers)
	texture_normal = data.icon
	
func _on_pressed():
	GameManager.try_purchase(data)
