extends Node2D

@onready
var ball = preload("res://scenes/ball/ball.tscn")

@export
var ball_remaining_count = 0
var ball_next_shoot_time : float = 0.0
var ball_color : Color

var ball_colors = [
	Color('#f48f30'),
	Color('#f43a30'),
	Color('#f430e9'),
	Color('#9930f4'),
	Color('#4a30f4'),
	Color('#309ff4'),
	Color('#30f49f'),
	Color('#3af430'),
	Color('#def430'),
]

func _ready():
	ball_remaining_count = max(10, GameManager.ball_max_count)
	ball_color = ball_colors[randi_range(0, 8)]

func shootOneRoundOBalls():
	ball_remaining_count -= 1
	ball_next_shoot_time = 0.048 # 1.5 * size / speed
	for step in range(8):
		var ball_instance = ball.instantiate()
		ball_instance.dir = deg_to_rad(22 + 45 * step)
		ball_instance.speed = ball_instance.speed * GameManager.speed_factor
		ball_instance.set_color(ball_color)
		add_child(ball_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball_remaining_count == 0:
		return
	
	ball_next_shoot_time -= delta
	if ball_next_shoot_time < 0.0:
		shootOneRoundOBalls()
