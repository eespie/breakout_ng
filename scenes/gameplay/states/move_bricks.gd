extends "res://StateMachine/state.gd"

@export
var idle_state : State

# set to idle state when necessary
var next_state

func enter() -> void:
	EventBus.sigStartMovingBricks.emit()

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	return idle_state
