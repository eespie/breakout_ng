extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigScorePointsUpdated.connect(_on_point_to_score_updated)

func _on_point_to_score_updated():
	var points = GameManager.total_points
	if points > 10000:
		points = "%.1fk" % (points / 1000.0)
	else:
		points = str(points)
	
	set_text(points)
