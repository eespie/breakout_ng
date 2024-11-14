extends TextureRect

@export var brick : StaticBody2D
	
func _can_drop_data(_at_position, _data):
	return brick.brick_type != "Explode"

func _drop_data(_at_position, data):
	brick.set_bonus_brick_type(data)
	GameManager.remove_item(data)
