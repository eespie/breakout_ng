extends Label

var total_points

# Called when the node enters the scene tree for the first time.
func _ready():
	total_points = 0
	EventBus.sigAddScorePoints.connect(_on_add_point_to_score)

func _on_add_point_to_score(points: int):
	total_points += points
	set_text(str(total_points))

func save_game():
	var save_dict = {
		"name" : get_path(),
		"total_points" : total_points
	}
	return save_dict

func load_game(node_data):
	total_points = node_data["total_points"]
	set_text(str(total_points))
