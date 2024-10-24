extends StaticBody2D

@export
var top_margin : int = 50

@export
var cell_margin : int = 30

@export
var cell_width : int = 120

@export
var cell_height : int = 122

var last_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEndMovingBricks.connect(_on_end_moving_bricks)

func set_column(column: int) -> void:
	position = Vector2(cell_margin/2 + cell_width * column, -top_margin)
	last_pos = position
	hide()
	
func move_down(step: float):
	position = last_pos + Vector2(0, cell_height * step)
	if position.y > 0:
		show()

func _on_end_moving_bricks():
	last_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
