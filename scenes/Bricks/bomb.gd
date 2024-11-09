extends Sprite2D

func brick_kill():
	var tween = get_tree().create_tween()
	for brk in get_tree().get_nodes_in_group("Bricks"):
		if brk.get_life_points() > 0:
			tween.tween_callback(brk.set_life_points).set_delay(.1)
