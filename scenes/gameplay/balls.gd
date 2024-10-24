extends Node2D

@onready
var ball = preload("res://scenes/Ball/Ball.tscn")

@onready
var raycast_line = $RayCastForAiming

var ballMaxCount = 1
var ballRemainingCountToShoot = 0
var ballCountActive = 0
var ballNextShootTime : float

func _ready():
	EventBus.sigBallShoot.connect(_on_ball_shoot)
	EventBus.sigBallRemoved.connect(_on_ball_removed)
	EventBus.sigAddNewBall.connect(_on_add_new_ball)

func _on_add_new_ball():
	ballMaxCount += 1

# Called when the node enters the scene tree for the first time.
func _on_ball_shoot():
	if not raycast_line.ballDir:
		EventBus.sigAbortAiming.emit()
		return
		
	ballRemainingCountToShoot = ballMaxCount
	ballNextShootTime = 0.0
	
func shootOneBall():
	var ballInstance = ball.instantiate()
	ballInstance.dir = raycast_line.ballDir
	add_child(ballInstance)
	ballCountActive += 1
	ballRemainingCountToShoot -= 1
	ballNextShootTime = 0.048 # 1.5 * size / speed

func _on_ball_removed(ballInstance : Node2D):
	ballInstance.queue_free()
	ballCountActive -= 1
	if ballCountActive == 0:
		EventBus.sigNoBallsRemaining.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ballRemainingCountToShoot == 0:
		return
	
	ballNextShootTime -= delta
	if ballNextShootTime < 0.0:
		shootOneBall()
