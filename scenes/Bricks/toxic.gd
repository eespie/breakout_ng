extends Sprite2D


func brick_kill():
	for brk in get_tree().get_nodes_in_group("Bricks"):
		if brk.get_life_points() > 0:
			brk.set_life_points(floori(brk.get_life_points() / 2.0))
