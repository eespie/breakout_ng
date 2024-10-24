extends StaticBody2D

var speed : float = 1000
var size = 26

var dir : float

func _ready():
	position = Vector2(0, 0)
	constant_linear_velocity = Vector2(0, -speed).rotated(dir)


func _physics_process(delta):
	var collision_info = move_and_collide(constant_linear_velocity * delta)
	if collision_info:
		constant_linear_velocity = constant_linear_velocity.bounce(collision_info.get_normal())
		EventBus.sigBallsCollided.emit(collision_info.get_collider(), self)
