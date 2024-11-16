extends Node2D

@onready
var brick = preload("res://scenes/bricks/polygon_brick.tscn")

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigStartMovingBricks.connect(_on_start_moving)
	EventBus.sigBallsCollided.connect(_on_ball_collided)
	EventBus.sigEndOfGame.connect(_on_end_of_game)

# Add a new levels of bricks
# Move down all the bricks
func _on_start_moving():
	var turns = min(GameManager.get_number_of_brick_lines(), 2)
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
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	for brk in get_tree().get_nodes_in_group("Bricks"):
		tween.tween_callback(brk.brick_kill).set_delay(.1)

func _generate_one_level_of_bricks():
	EventBus.sigNextLevel.emit(GameManager.level + 1)
	var brick_types = ['ball', 'point', 'base', 'base', 'base', 'base', 'base']
	var nb_bricks = randi_range(0, get_max_bricks()) + 2
	var columns = {}
	for i in range(nb_bricks):
		var brick_instance = brick.instantiate()
		var column = randi_range(0, 7)
		while columns.has(column):
			column = randi_range(0, 7)
		columns[column] = column
		var type = brick_types[i]
		var life_mult = 1
		#if GameManager.level % 50 == 0 and i == (nb_bricks - 1):
		#	type = 'Explode'
		#	life_mult = 2
		brick_instance.create_brick(column, GameManager.brick_life * life_mult, type)
		add_child(brick_instance)

# Move down bricks using step between 0 and 1
func _move_down_bricks(step: float):
	for brk in get_tree().get_nodes_in_group("Bricks"):
		brk.move_down(step)

# Use weighted random to get the number of additional bricks
func get_max_bricks() -> int:
	var curr_level = GameManager.level
	if curr_level > 240:
		curr_level = 240
	var value = TriangulaDistribution.get_value(0, curr_level, 250)
	
	return floori(value / 50.0)

func _on_ball_collided(collider : Node2D, ball : Node2D):
	if collider.is_in_group("Bricks"):
		collider.ball_collided(ball)

func save_game():
	var bricks_to_save = []
	for brk in get_tree().get_nodes_in_group("Bricks"):
		bricks_to_save.append({
			"pos_x" : brk.position.x,
			"pos_y" : brk.position.y,
			"life_points" : brk.life_points,
			"starting_life_points" : brk.starting_life_points,
			"brick_type" : brk.brick_type,
			"bonus_amount" : brk.bonus_amount
		})
	var save_dict = {
		"name" : get_path(),
		"bricks" : bricks_to_save
	}
	return save_dict

func load_game(node_data):
	if GameManager.level == 0:
		return
	for brick_data in node_data["bricks"]:
		var brick_instance = brick.instantiate()
		brick_instance.load_brick(
			Vector2(brick_data["pos_x"], brick_data["pos_y"]),
			brick_data["starting_life_points"],
			brick_data["life_points"],
			brick_data["brick_type"],
			brick_data["bonus_amount"]
			)
		add_child(brick_instance)
