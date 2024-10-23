extends Control

@onready var StateMachine = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)
	StateMachine.init()

func _on_end_of_round():
	print("End of Round")

func _process(delta):
	StateMachine.process_frame(delta)
	
func _physics_process(delta):
	StateMachine.process_physics(delta)
	
func _input(event):
	StateMachine.process_input(event)
