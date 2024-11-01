extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigBallCountUpdated.connect(_on_ball_cout_updated)
	
func _on_ball_cout_updated(ball_count : int):
	set_text(str(ball_count))
