extends Node2D

@onready
var brick = preload("res://scenes/bricks/polygon_brick.tscn")

@export
var level: int = 0
var brick_life: int

var tween: Tween
var game_ended : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigStartMovingBricks.connect(_on_start_moving)
	EventBus.sigBallsCollided.connect(_on_ball_collided)
	EventBus.sigEndOfGame.connect(_on_end_of_game)
	EventBus.sigAddNewBalls.connect(_on_add_new_balls)

# Add a new level of bricks
# Move down all the bricks
func _on_start_moving():
	var turns = ceili(level / 50) + 1
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	for turn in range(turns):
		# Now move down all the bricks
		tween.tween_callback(_generate_one_level_of_bricks)
		tween.tween_method(_move_down_bricks, 0.0, 1.0, 1)
		tween.tween_callback(EventBus.sigEndMovingBricks.emit)
		
	tween.tween_callback(EventBus.sigEndStateMovingBricks.emit)
	
func _on_end_of_game():
	print("End of game")
	if tween:
		tween.kill()
	game_ended = true

func _generate_one_level_of_bricks():
	level += 1
	brick_life += 1
	EventBus.sigNextLevel.emit(level)
	var brick_types = ['ball', 'point', 'base', 'base', 'base', 'base', 'base']
	var nb_bricks = randi_range(0, get_max_bricks()) + 2
	var columns = {}
	for i in range(nb_bricks):
		var brick_instance = brick.instantiate()
		var column = randi_range(0, 7)
		while columns.has(column):
			column = randi_range(0, 7)
		columns[column] = column
		brick_instance.init_brick(column, brick_life, brick_types[i])
		add_child(brick_instance)

# Move down bricks using step between 0 and 1
func _move_down_bricks(step: float):
	for brk in get_tree().get_nodes_in_group("Bricks"):
		brk.move_down(step)

# Use weighted random to get the number of additional bricks
func get_max_bricks() -> int:
	var curr_level = level
	if level > 240:
		curr_level = 240
	var value = TriangulaDistribution.get_value(0, curr_level, 250)
	
	return floori(value / 50.0)

func _on_ball_collided(collider : Node2D, ball : Node2D):
	if collider.is_in_group("Bricks"):
		collider.ball_collided(ball)

func _on_add_new_balls(balls: int):
	pass
