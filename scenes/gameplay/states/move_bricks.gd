extends "res://state_machine/state.gd"

@export
var idle_state : State

@export
var end_game_state : State

@export
var red_zone : Sprite2D

# set to idle or end game state when necessary
var next_state

func enter() -> void:
	next_state = null
	EventBus.sigEndStateMovingBricks.connect(_on_end_moving_bricks)
	EventBus.sigEndOfGame.connect(_on_end_of_game)
	
	for brk in get_tree().get_nodes_in_group("Bricks"):
		if brk.position.y > red_zone.get_offset().y:
			EventBus.sigEndOfGame.emit()
			return;
	
	EventBus.sigStartMovingBricks.emit()

func exit() -> void:
	EventBus.sigEndStateMovingBricks.disconnect(_on_end_moving_bricks)
	EventBus.sigEndOfGame.disconnect(_on_end_of_game)

func _on_end_moving_bricks():
	next_state = idle_state
	
func _on_end_of_game():
	next_state = end_game_state

func process_frame(_delta: float) -> State:
	return next_state
