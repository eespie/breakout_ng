extends Node2D

@onready
var brick = preload("res://scenes/Bricks/Base/base_brick.tscn")

@export
var level: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigStartMovingBricks.connect(_on_start_moving)

# Add a new level of bricks
# Move down all the bricks
func _on_start_moving():
	var turns = ceili(level / 50) + 1
	for turn in range(turns):
		level += 1
		EventBus.sigNextLevel.emit(level)
		var nb_bricks = randi_range(0, get_max_bricks()) + 2
		var columns = {}
		for i in range(nb_bricks):
			var brick_instance = brick.instantiate()
			var column = randi_range(0, 7)
			while columns.has(column):
				column = randi_range(0, 7)
			columns[column] = column
			brick_instance.set_column(column)
			add_child(brick_instance)
	
	# Now move down all the bricks
	var tween = get_tree().create_tween()
	tween.tween_method(_move_down_bricks, 0.0, 1.0, 1)
	tween.tween_callback(EventBus.sigEndMovingBricks.emit)
	

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
