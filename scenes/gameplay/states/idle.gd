extends "res://StateMachine/state.gd"

@export
var aim_state : State

func process_input(event: InputEvent) -> State:
	if event is InputEventMouseButton:
		if event.is_pressed():
			return aim_state
		
	# Not relevant
	return null
