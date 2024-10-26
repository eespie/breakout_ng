extends Label

var total_points

# Called when the node enters the scene tree for the first time.
func _ready():
	total_points = 0
	EventBus.sigAddScorePoint.connect(_on_add_point_to_score)

func _on_add_point_to_score():
	total_points += 1
	set_text(str(total_points))
