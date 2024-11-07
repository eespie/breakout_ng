extends TextureButton


func _ready():
	EventBus.sigLoadPermanentDataDone.connect(_on_data_loaded)

func _on_data_loaded():
	if GameManager.total_points < 2000:
		set_disabled(true)
	else:
		set_disabled(false)


func _on_pressed():
	GameManager.add_item("Bomb")
	SaveGame.save_permanent_data()
	EventBus.sigStoreItemPurchased.emit("Bomb", 2000)
