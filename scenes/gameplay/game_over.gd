extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEndOfGame.connect(_on_end_of_game)

func _on_end_of_game():
	show()
