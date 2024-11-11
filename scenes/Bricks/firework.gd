extends Sprite2D

var brick

func brick_kill():
	print("brick pos: ", position)
	EventBus.sigFireworkStart.emit(brick.position + Vector2(45, 61))

func set_brick(_brick):
	brick = _brick
