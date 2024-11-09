extends TextureRect

@export var brick : StaticBody2D
	
func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	brick.set_bonus_brick_type(data)
	GameManager.remove_item(data)
