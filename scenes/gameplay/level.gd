extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigNextLevel.connect(_on_next_level)

func _on_next_level(level : int):
	set_text(str(level))
