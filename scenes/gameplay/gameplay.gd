extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)


func _on_end_of_round():
	print("End of Round")
