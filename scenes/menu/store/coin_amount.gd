extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigLoadPermanentDataDone.connect(_on_data_loaded)

func _on_data_loaded():
	set_text(str(GameManager.total_points))
