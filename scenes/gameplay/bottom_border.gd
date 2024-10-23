extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigBallsCollided.connect(_on_ball_collided)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_ball_collided(object : Node2D, ball : Node2D):
	if object == self:
		EventBus.sigBallRemoved.emit(ball)
