extends "res://StateMachine/state.gd"

@export
var move_bricks_state: State

var next_state: State

func enter() -> void:
	EventBus.sigBallShoot.emit()
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)
	
func _on_end_of_round():
	next_state = move_bricks_state
	
func process_frame(delta: float) -> State:
	var state = next_state
	next_state = null
	return state
