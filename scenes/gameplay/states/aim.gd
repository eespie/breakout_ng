extends "res://StateMachine/state.gd"

@export
var run_state: State

func process_input(event: InputEvent) -> State:	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#var pos = make_input_local(event).position
		if not event.is_pressed():
			EventBus.sigStopAiming.emit()
			return run_state
	elif event is InputEventMouseMotion:
		EventBus.sigMouseAiming.emit(event.position)
		
	return null
