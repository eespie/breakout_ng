extends StaticBody2D

@export
var top_margin : int = 50

@export
var cell_margin : int = 30

@export
var cell_width : int = 120

@export
var cell_height : int = 122

var life_points : int
var last_pos : Vector2
var brick_type : String

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEndMovingBricks.connect(_on_end_moving_bricks)
	
func init_brick(column: int, level: int, type):
	_set_column(column)
	life_points = level
	brick_type = type
	if brick_type == 'ball':
		set_modulate(Color.DARK_OLIVE_GREEN)
	elif brick_type == 'point':
		set_modulate(Color.DARK_SALMON)


func _set_column(column: int) -> void:
	position = Vector2(cell_margin/2 + cell_width * column, -top_margin)
	last_pos = position
	hide()
	
func move_down(step: float):
	position = last_pos + Vector2(0, cell_height * step)
	if position.y > 0:
		show()

func _on_end_moving_bricks():
	last_pos = position
		

func ball_collided(_ball : Node2D):
	life_points -= 1
		
	if life_points == 0:
		# avoid future collisions
		set_collision_layer_value(2, false)
		if brick_type == 'ball':
			EventBus.sigAddNewBall.emit()
		elif brick_type == 'point':
			EventBus.sigAddScorePoints.emit(1)

		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.RED, 0.1).set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "scale", Vector2(), 0.1).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_callback(self.queue_free)
