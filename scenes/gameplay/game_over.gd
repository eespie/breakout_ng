extends Label

@onready var coins_earned_on_game_over = %CoinsEarnedOnGameOver

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEndOfGame.connect(_on_end_of_game)
	EventBus.sigAddScorePoints.connect(_on_points_added)

func _on_end_of_game():
	show()

func _on_points_added(points: int):
	coins_earned_on_game_over.set_text("%d coins earned" % points)
