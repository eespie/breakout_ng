extends StaticBody2D

@export var top_margin : int = 50
@export var cell_margin : int = 30
@export var cell_width : int = 120
@export var cell_height : int = 122

@export var extra_ball : Sprite2D
@export var extra_coin : Sprite2D
@export var extra_balls : Sprite2D
@export var extra_coins : Sprite2D
@export var brick_sprite : Sprite2D
@export var brick_mask : Sprite2D
@export var brick_mask_cracked : Sprite2D
@export var bonus1 : Sprite2D
@export var bonus2 : Sprite2D
@export var bonus3 : Sprite2D

@onready var bonus_extra_ball = preload("res://scenes/bricks/bonus/extra_ball.tscn")
@onready var bonus_extra_coin = preload("res://scenes/bricks/bonus/extra_coin.tscn")
@onready var bonus_masks = {
	'Toxic' : $Deco/Toxic,
	'Firework' : $Deco/Firework,
	'Bomb' : $Deco/Bomb
	}

var life_points : int
var starting_life_points : int
var last_pos : Vector2
var brick_type : String
var bonus_amount : int

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEndMovingBricks.connect(_on_end_moving_bricks)
	if bonus_masks.has(brick_type):
		bonus_masks[brick_type].show()
	
	
func init_brick(column: int, life: int, type):
	_set_column(column)
	var bonus = 0
	if type == 'ball':
		bonus = get_bonus_amount([[0.95, 1], [0.99, 2], [1.0, 3]])
	elif type == 'point':
		bonus = get_bonus_amount([[0.85, 1], [0.95, 3], [0.98, 5], [1.0, 10]])
	display_brick(position, life, life, type, bonus)
		
func display_brick(pos : Vector2, starting_life : int, life : int, type : String, bonus : int):
	position = pos
	last_pos = pos
	starting_life_points = starting_life
	life_points = life
	brick_type = type
	bonus_amount = bonus
	brick_mask_cracked.set_modulate(Color(1.0,1.0,1.0,1.0*(starting_life_points - life_points)/starting_life_points))
	if brick_type == 'ball':
		brick_sprite.set_modulate(Color.DARK_OLIVE_GREEN)
		if bonus_amount == 1:
			extra_ball.show()
		else:
			extra_balls.show()
			if bonus_amount == 2:
				bonus2.show()
				bonus3.show()
			else:
				bonus1.show()
				bonus2.show()
				bonus3.show()
	elif brick_type == 'point':
		brick_sprite.set_modulate(Color.ORANGE)
		if bonus_amount == 1:
			extra_coin.show()
		else:
			extra_coins.show()
			if bonus_amount == 3:
				bonus1.show()
			elif bonus_amount == 5:
				bonus2.show()
				bonus3.show()
			else:
				bonus1.show()
				bonus2.show()
				bonus3.show()
	else:
		brick_sprite.set_modulate(Color.MEDIUM_PURPLE)
	
func _set_column(column: int) -> void:
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
	
func set_life_points(points : int):
	life_points = points
	brick_mask_cracked.set_modulate(Color(1.0,1.0,1.0,1.0*(starting_life_points - life_points)/starting_life_points))
	if life_points == 0:
		brick_kill(true)

func get_life_points() -> int:
	return life_points

func set_bonus_brick_type(type : String):
	brick_type = type
	life_points = 1
	bonus_masks[type].show()

func brick_kill(can_get_points : bool = false):
	# avoid future collisions
	set_collision_layer_value(2, false)
	var tween = get_tree().create_tween()
	tween.tween_property(brick_sprite, "modulate", Color.RED, 0.1).set_trans(Tween.TRANS_SINE)
	brick_mask.hide()
	brick_mask_cracked.hide()
	extra_ball.hide()
	extra_balls.hide()
	extra_coin.hide()
	extra_coins.hide()
	bonus1.hide()
	bonus2.hide()
	bonus3.hide()
	tween.tween_property(self, "scale", Vector2(), 0.1).set_trans(Tween.TRANS_BOUNCE)
	if bonus_masks.has(brick_type):
		bonus_masks[brick_type].brick_kill()
	
	if can_get_points:
		if brick_type == 'ball':
			var bonus_instance = bonus_extra_ball.instantiate()
			bonus_instance.position = Vector2(46, 61)
			add_child(bonus_instance)
			var target : Sprite2D
			for cannon in get_tree().get_nodes_in_group("TargetExtraBall"):
				target = cannon
		
			tween.tween_property(bonus_instance, "global_position", target.global_position, 0.8)
			tween.tween_callback(_earn_bonus)
			
		elif brick_type == 'point':
			var bonus_instance = bonus_extra_coin.instantiate()
			bonus_instance.position = Vector2(46, 61)
			add_child(bonus_instance)
			var target : Sprite2D
			for score_coin in get_tree().get_nodes_in_group("TargetExtraCoin"):
				target = score_coin
		
			tween.tween_property(bonus_instance, "global_position", target.global_position, 0.8)
			tween.tween_callback(_earn_bonus)

	tween.tween_callback(self.queue_free)

func get_bonus_amount(steps) -> int:
	var v = randf()
	for step in steps:
		if v < step[0]:
			return step[1]
	return 1

func _earn_bonus():
	if brick_type == 'ball':
		EventBus.sigAddNewBalls.emit(bonus_amount)
		
	elif brick_type == 'point':
		EventBus.sigAddScorePoints.emit(bonus_amount)
		
