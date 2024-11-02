extends Node

var level: int = 0
var max_level: int = 0
var brick_life: int = 0

var ball_max_count: int = 1

var total_points: int = 0

var replay_bonus : int = 0


func _ready():
	EventBus.sigAddScorePoints.connect(_on_add_point_to_score)
	EventBus.sigNextLevel.connect(_on_next_level)
	EventBus.sigAddNewBalls.connect(_on_add_new_ball)
	EventBus.sigEndOfGame.connect(_on_end_of_game)

func get_number_of_brick_lines() -> int:
	return min(ceili(level / 50) + 1, 4)


func _on_add_point_to_score(points: int):
	total_points += points
	EventBus.sigScorePointsUpdated.emit()

func _on_next_level(lvl : int):
	level = lvl
	brick_life = lvl
	if level > max_level:
		max_level = level
		EventBus.sigMaxLevel.emit(max_level)

func _on_add_new_ball(balls : int):
	ball_max_count += balls
	EventBus.sigBallCountUpdated.emit(ball_max_count)
	
func _on_end_of_game():
	level = 0
	ball_max_count = 1
	SaveGame.save_game()

func save_game():
	var save_dict = {
		"name" : "GameManager",
		"level" : level,
		"max_level" : max_level,
		"brick_life" : brick_life,
		"ball_max_count" : ball_max_count,
		"total_points" : total_points,
		"replay_bonus" : replay_bonus,
	}
	return save_dict

func load_game(node_data):
	level = node_data["level"]
	max_level = node_data["max_level"]
	brick_life = node_data["brick_life"]
	EventBus.sigNextLevel.emit(level)
	EventBus.sigMaxLevel.emit(max_level)
	
	total_points = node_data["total_points"]
	EventBus.sigScorePointsUpdated.emit()
	
	replay_bonus = node_data["replay_bonus"]
	
	ball_max_count = node_data["ball_max_count"]
	EventBus.sigBallCountUpdated.emit(ball_max_count)
	
