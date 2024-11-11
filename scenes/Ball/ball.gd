extends StaticBody2D

@export
var speed : float = 1000
var size = 26
var dir : float

func _ready():
	position = Vector2(0, 0)
	constant_linear_velocity = Vector2(0, -speed).rotated(dir)

func set_color(color : Color):
	set_modulate(color)

func speed_up(speed_factor: float):
	speed = 1000.0 * speed_factor
	var velocity_dir = constant_linear_velocity.normalized()
	if speed_factor > 5:
		velocity_dir.y -= 0.0001
	constant_linear_velocity = velocity_dir * speed

func _physics_process(delta):
	var collision_info = move_and_collide(constant_linear_velocity * delta)
	if collision_info:
		constant_linear_velocity = constant_linear_velocity.bounce(collision_info.get_normal())
		EventBus.sigBallsCollided.emit(collision_info.get_collider(), self)
