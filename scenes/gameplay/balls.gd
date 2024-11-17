extends Node2D

@onready
var ball = preload("res://scenes/ball/ball.tscn")

@onready
var raycast_line = $RayCastForAiming

@export
var ball_remaining_count = 0
var ball_next_shoot_time : float

func _ready():
	EventBus.sigBallsStartShooting.connect(_on_ball_start_shooting)
	EventBus.sigBallRemoved.connect(_on_ball_removed)

# Called when the node enters the scene tree for the first time.
func _on_ball_start_shooting():
	if not raycast_line.ballDir:
		EventBus.sigAbortAiming.emit()
		return
	
	ball_remaining_count = floori(GameManager.ball_max_count)
	ball_next_shoot_time = 0.0
	
func shootOneBall():
	var ballInstance = ball.instantiate()
	ballInstance.dir = raycast_line.ballDir
	ballInstance.speed = ballInstance.speed * GameManager.speed_factor
	add_child(ballInstance)
	ball_remaining_count -= 1
	ball_next_shoot_time = 0.048 # 1.5 * size / speed

func _on_ball_removed(ballInstance : Node2D):
	ballInstance.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball_remaining_count == 0:
		return
	
	ball_next_shoot_time -= delta
	if ball_next_shoot_time < 0.0:
		shootOneBall()
