extends Sprite2D

@export var bonus_amount : int


func earn_bonus(brick_type : String):
	if brick_type == 'ball':
		EventBus.sigAddNewBalls.emit(bonus_amount)
		
	elif brick_type == 'point':
		EventBus.sigAddScorePoints.emit(bonus_amount)
