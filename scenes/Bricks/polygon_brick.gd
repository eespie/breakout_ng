extends StaticBody2D

@export var top_margin : int = 50
@export var cell_margin : int = 30
@export var cell_width : int = 120
@export var cell_height : int = 122

@export var brick_sprite : Sprite2D
@export var brick_mask : Sprite2D
@export var brick_mask_cracked : Sprite2D
@onready var bonus_masks = [
	$Deco/Bonus1,
	$Deco/Bonus1,
	$Deco/Bonus2,
	$Deco/Bonus3,
	$Deco/Bonus4,
	$Deco/Bonus5,
	$Deco/Bonus5,
	$Deco/Bonus5,
	$Deco/Bonus5,
	$Deco/Bonus5,
	$Deco/Bonus10,
]
@onready var type_masks = {
	'Toxic' : $Type/Toxic,
	'Firework' : $Type/Firework,
	'Bomb' : $Type/Bomb
}
@onready var deco = $Deco

@onready var bonus_extra_ball = preload("res://scenes/bricks/bonus/extra_ball.tscn")
@onready var bonus_extra_coin = preload("res://scenes/bricks/bonus/extra_coin.tscn")

var life_points : int
var starting_life_points : int
var last_pos : Vector2
var brick_type : String
var bonus_amount : int

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEndMovingBricks.connect(_on_end_moving_bricks)
	if type_masks.has(brick_type):
		type_masks[brick_type].show()
		if brick_type == 'Firework':
			type_masks[brick_type].set_brick(self)
	_display_brick()
	
func load_brick(pos : Vector2, starting_life : int, life : int, type : String, bonus : int):
	position = pos
	last_pos = pos
	starting_life_points = starting_life
	life_points = life
	brick_type = type
	bonus_amount = bonus

func create_brick(column: int, life: int, type):
	_init_column(column)
	_init_bonus(type)
	starting_life_points = life
	life_points = life
	brick_type = type
	last_pos = position

func _display_brick():
	brick_mask_cracked.set_modulate(Color(1.0,1.0,1.0,1.0*(starting_life_points - life_points)/starting_life_points))
	if brick_type == 'ball':
		brick_sprite.set_modulate(Color.DARK_OLIVE_GREEN)
		bonus_masks[bonus_amount].show()
	elif brick_type == 'point':
		brick_sprite.set_modulate(Color.ORANGE)
		bonus_masks[bonus_amount].show()
		bonus_masks[bonus_amount].set_modulate(Color.GOLD)
	else:
		brick_sprite.set_modulate(Color.MEDIUM_PURPLE)
	if type_masks.has(brick_type):
		type_masks[brick_type].show()

func _init_bonus(type: String) -> void:
	var bonus = 0
	if type == 'ball':
		bonus = get_bonus_amount([[0.95, 1], [0.99, 2], [1.0, 3]])
	elif type == 'point':
		bonus = get_bonus_amount([[0.85, 1], [0.90, 2], [0.93, 3], [0.95, 4], [0.98, 5], [1.0, 10]])
	bonus_amount = bonus

func _init_column(column: int) -> void:
	position = Vector2(roundi(cell_margin/2.0 + cell_width * column), -top_margin)
	last_pos = position
	hide()
	
func move_down(step: float):
	position = last_pos + Vector2(0, cell_height * step)
	if position.y > 0:
		show()

func _on_end_moving_bricks():
	last_pos = position

func ball_collided(_ball : Node2D):
	set_life_points(life_points - 1)
	
func set_life_points(points : int = 0):
	life_points = points
	brick_mask_cracked.set_modulate(Color(1.0,1.0,1.0,1.0*(starting_life_points - life_points)/starting_life_points))
	if life_points == 0:
		brick_kill(true)

func get_life_points() -> int:
	return life_points

func set_bonus_brick_type(type : String):
	brick_type = type
	life_points = 1
	bonus_amount = 0
	type_masks[type].show()
	if brick_type == 'Firework':
		type_masks[brick_type].set_brick(self)

func brick_kill(can_get_points : bool = false):
	# avoid future collisions
	set_collision_layer_value(2, false)
	var tween = get_tree().create_tween()
	tween.tween_property(brick_sprite, "modulate", Color.RED, 0.1).set_trans(Tween.TRANS_SINE)
	brick_mask.hide()
	brick_mask_cracked.hide()
	deco.hide()
	tween.tween_property(self, "scale", Vector2(), 0.1).set_trans(Tween.TRANS_BOUNCE)
	if type_masks.has(brick_type):
		type_masks[brick_type].brick_kill()
	
	if can_get_points and (brick_type == 'ball' or brick_type == 'point'):
		bonus_masks[bonus_amount].earn_bonus(brick_type)

	tween.tween_callback(self.queue_free)

func get_bonus_amount(steps) -> int:
	var v = randf()
	for step in steps:
		if v < step[0]:
			return step[1]
	return 1
