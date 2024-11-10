extends "res://state_machine/state.gd"

@export var run_state: State
@export var idle_state: State

var game_area : Sprite2D
var elapsed = 0

func enter() -> void:
	elapsed = Time.get_unix_time_from_system()
	# Store the game area to restrict the aiming
	for bg in get_tree().get_nodes_in_group("GameArea"):
		game_area = bg

func process_input(event: InputEvent) -> State:	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#var pos = make_input_local(event).position
		if not event.is_pressed():
			EventBus.sigStopAiming.emit()
			elapsed = Time.get_unix_time_from_system() - elapsed
			if elapsed < 0.3:
				return idle_state
			return run_state
	elif event is InputEventMouseMotion:
		var event_pos = game_area.to_local(event.position)
		var game_rect = game_area.get_rect()
		# Allow horizontal outbounding
		if event_pos.x < 0:
			event_pos.x = 0
		elif event_pos.x > game_rect.size.x - 1:
			event_pos.x = game_rect.size.x - 1
		if game_rect.has_point(event_pos):
			EventBus.sigMouseAiming.emit(event.position)
		
	return null
