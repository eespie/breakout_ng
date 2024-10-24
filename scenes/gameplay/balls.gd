extends Node2D

@onready var ball = preload("res://scenes/Ball/Ball.tscn")
var ballMaxCount = 100
var ballRemainingCountToShoot = 0
var ballCountActive = 0
var ballNextShootTime : float
var ballDir

func _ready():
	EventBus.sigBallShoot.connect(_on_ball_shoot)
	EventBus.sigBallRemoved.connect(_on_ball_removed)
	EventBus.sigMouseAiming.connect(_on_aiming)

# Called when the node enters the scene tree for the first time.
func _on_ball_shoot():
	if not ballDir:
		EventBus.sigAbortAiming.emit()
		return
		
	ballRemainingCountToShoot = ballMaxCount
	ballNextShootTime = 0.0
	
func shootOneBall():
	var ballInstance = ball.instantiate()
	ballInstance.dir = ballDir
	add_child(ballInstance)
	ballCountActive += 1
	ballRemainingCountToShoot -= 1
	ballNextShootTime = 0.048 # 1.5 * size / speed

func _on_ball_removed(ballInstance : Node2D):
	ballInstance.queue_free()
	ballCountActive -= 1
	if ballCountActive == 0:
		EventBus.sigNoBallsRemaining.emit()

func _on_aiming(global_aiming_pos : Vector2):
	var angle = global_position.angle_to_point(global_aiming_pos)
	if angle < 0:
		ballDir = deg_to_rad(90) + angle
	else:
		ballDir = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ballRemainingCountToShoot == 0:
		return
	
	ballNextShootTime -= delta
	if ballNextShootTime < 0.0:
		shootOneBall()
