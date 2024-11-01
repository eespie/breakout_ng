extends "res://StateMachine/state.gd"

@export
var aim_state : State

var game_area : Sprite2D

func enter() -> void:
	# Store the game area to restrict the aiming
	for bg in get_tree().get_nodes_in_group("GameArea"):
		game_area = bg

func process_input(event: InputEvent) -> State:
	if event is InputEventMouseButton:
		if event.is_pressed() and game_area.get_rect().has_point(game_area.to_local(event.position)):
			return aim_state
		
	# Not relevant
	return null
