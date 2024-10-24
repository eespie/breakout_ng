extends "res://StateMachine/state.gd"

@export
var move_bricks_state: State

@export
var idle_state: State

var next_state: State

func enter() -> void:
	next_state = null
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)
	EventBus.sigAbortAiming.connect(_on_abort_aiming)
	EventBus.sigBallShoot.emit()
	
func exit() -> void:
	next_state = null
	EventBus.sigNoBallsRemaining.disconnect(_on_end_of_round)
	EventBus.sigAbortAiming.disconnect(_on_abort_aiming)

func _on_abort_aiming():
	next_state = idle_state
	
func _on_end_of_round():
	next_state = move_bricks_state
	
func process_frame(_delta: float) -> State:
	return next_state
