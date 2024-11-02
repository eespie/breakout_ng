extends Node2D

@onready
var ball = preload("res://scenes/ball/ball.tscn")

@onready
var raycast_line = $RayCastForAiming

@export
var ballRemainingCountToShoot = 0
var ballCountActive = 0
var ballNextShootTime : float
var ballSpeedFactor : float

func _ready():
	EventBus.sigBallShoot.connect(_on_ball_shoot)
	EventBus.sigBallRemoved.connect(_on_ball_removed)
	EventBus.sigSpeedFactorChanged.connect(_on_speed_factor_changed)

# Called when the node enters the scene tree for the first time.
func _on_ball_shoot():
	if not raycast_line.ballDir:
		EventBus.sigAbortAiming.emit()
		return
	
	ballSpeedFactor = 1.0
	ballRemainingCountToShoot = GameManager.ball_max_count
	ballNextShootTime = 0.0
	
func shootOneBall():
	var ballInstance = ball.instantiate()
	ballInstance.dir = raycast_line.ballDir
	ballInstance.speed = ballInstance.speed * ballSpeedFactor
	add_child(ballInstance)
	ballCountActive += 1
	ballRemainingCountToShoot -= 1
	ballNextShootTime = 0.048 # 1.5 * size / speed

func _on_ball_removed(ballInstance : Node2D):
	ballInstance.queue_free()
	ballCountActive -= 1
	if ballCountActive == 0:
		EventBus.sigNoBallsRemaining.emit()
		
func _on_speed_factor_changed(speed_factor: float):
	ballSpeedFactor = speed_factor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ballRemainingCountToShoot == 0:
		return
	
	ballNextShootTime -= delta
	if ballNextShootTime < 0.0:
		shootOneBall()
