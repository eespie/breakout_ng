extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigMaxLevel.connect(_on_max_level_changed)

func _on_max_level_changed(max_level : int):
	set_text(str(max_level))
