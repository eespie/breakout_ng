extends "res://StateMachine/state.gd"

@export
var idle_state : State

func process_frame(_delta: float) -> State:
	return idle_state
