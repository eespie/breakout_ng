extends Label

var total_points

# Called when the node enters the scene tree for the first time.
func _ready():
	total_points = 0
	EventBus.sigAddScorePoints.connect(_on_add_points_to_score)

func _on_add_points_to_score(points : int):
	total_points += points
	set_text(str(total_points))
