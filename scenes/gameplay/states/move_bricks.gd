extends "res://StateMachine/state.gd"

@export
var idle_state : State

# set to idle state when necessary
var next_state

func enter() -> void:
	EventBus.sigStartMovingBricks.emit()
	EventBus.sigEndMovingBricks.connect(_on_end_moving_bricks)

func exit() -> void:
	pass

func _on_end_moving_bricks():
	next_state = idle_state

func process_frame(_delta: float) -> State:
	return next_state
