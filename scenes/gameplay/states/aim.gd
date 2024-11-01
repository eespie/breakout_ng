extends "res://StateMachine/state.gd"

@export
var run_state: State

var game_area : Sprite2D

func enter() -> void:
	# Store the game area to restrict the aiming
	for bg in get_tree().get_nodes_in_group("GameArea"):
		game_area = bg

func process_input(event: InputEvent) -> State:	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#var pos = make_input_local(event).position
		if not event.is_pressed():
			EventBus.sigStopAiming.emit()
			return run_state
	elif event is InputEventMouseMotion:
		if game_area.get_rect().has_point(game_area.to_local(event.position)):
			EventBus.sigMouseAiming.emit(event.position)
		
	return null
