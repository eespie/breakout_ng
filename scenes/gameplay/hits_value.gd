extends Label

var hits : float = 0
var balls_count : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigBallsCollided.connect(_on_ball_collided)
	EventBus.sigEnterState.connect(_on_enter_state)
	EventBus.sigBallSpawned.connect(_on_ball_spawned)
	display()

func _on_ball_spawned():
	balls_count += 1

func _on_ball_collided(collider : Node2D, ball : Node2D):
	if collider.is_in_group("Bricks"):
		hits += 1
		display()

func _on_enter_state(state : String):
	if state == "Run":
		hits = 0
		balls_count = 0
		display()
		show()

func display() -> void:
	var ratio = 0
	if balls_count != 0:
		ratio = hits / balls_count
	set_text("hit ratio %3.1f" % ratio)
