extends Sprite2D

var bonus = -100
var life_boost = 1.3

func earn_bonus(brick_type : String):
	EventBus.sigAddScorePoints.emit(-1)

func reclaim_bonus():
	bonus = 100
	life_boost = 0.25
	
func brick_kill():
	EventBus.sigAddScorePoints.emit(bonus)
	for brk in get_tree().get_nodes_in_group("Bricks"):
		if brk.get_life_points() > 0:
			brk.set_life_points(floori(brk.get_life_points() * life_boost))
