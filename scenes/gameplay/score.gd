extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigScorePointsUpdated.connect(_on_point_to_score_updated)

func _on_point_to_score_updated():
	set_text(str(GameManager.total_points))
