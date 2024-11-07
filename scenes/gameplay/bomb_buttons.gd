extends TextureButton


@onready var label = $BombCount

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigLoadPermanentDataDone.connect(_on_data_loaded)

func _on_data_loaded():
	var count = 0
	if GameManager.items.has('Bomb'):
		count = GameManager.items['Bomb']
	
	if count == 0:
		set_disabled(true)
		label.hide()
	else:
		set_disabled(false)
		label.show()
	
	label.set_text(str(count))
