extends Label

var hits : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigBallsCollided.connect(_on_ball_collided)
	EventBus.sigEnterState.connect(_on_enter_state)
	display()

func _on_ball_collided(collider : Node2D, ball : Node2D):
	if collider.is_in_group("Bricks"):
		hits += 1
		display()

func _on_enter_state(state : String):
	if state == "Run":
		hits = 0
		display()
		show()

func display() -> void:
	var ratio = 0
	if GameManager.level != 0:
		ratio = hits * 1.0 / (GameManager.level * 1.0)
	set_text("hit ratio: %3.1f" % ratio)
