extends Control

@onready
var StateMachine = $StateMachine

var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)
	EventBus.sigEndStateMovingBricks.connect(_on_end_moving_bricks)
	EventBus.sigNextLevel.connect(_on_next_level)
	StateMachine.init()

func start():
	SaveGame.load_game()
	StateMachine.start_game(level)

# Used only once after loading the game to know which state to start with
func _on_next_level(lvl : int):
	level = lvl
	EventBus.sigNextLevel.disconnect(_on_next_level)
	
func _on_end_of_round():
	SaveGame.save_game()
	print("End of Round")
	
func _on_end_moving_bricks():
	SaveGame.save_game()

func _process(delta):
	StateMachine.process_frame(delta)
	
func _physics_process(delta):
	StateMachine.process_physics(delta)
	
func _input(event):
	StateMachine.process_input(event)
