extends TextureButton


func _ready():
	EventBus.sigLoadPermanentDataDone.connect(_on_data_loaded)

func _on_data_loaded():
	if GameManager.total_points < 500:
		set_disabled(true)
	else:
		set_disabled(false)

func _on_pressed():
	GameManager.update_total_points(-500)
	GameManager.add_item("Toxic")
	SaveGame.save_permanent_data()
	EventBus.sigStoreItemPurchased.emit("Toxic", 500)
