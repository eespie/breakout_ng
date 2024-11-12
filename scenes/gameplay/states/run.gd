extends "res://state_machine/state.gd"

@export var move_bricks_state: State
@export var idle_state: State

var next_state: State
var speed_factor: float = 1.0
var game_area : Sprite2D
var elapsed : float

func enter() -> void:
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)
	EventBus.sigAbortAiming.connect(_on_abort_aiming)
	# Store the game area to restrict the aiming
	for bg in get_tree().get_nodes_in_group("GameArea"):
		game_area = bg
	next_state = null
	speed_factor = 1.0
	elapsed = 0
	EventBus.sigSpeedFactorChanged.emit(speed_factor)
	EventBus.sigBallShoot.emit()
	
func exit() -> void:
	next_state = null
	EventBus.sigNoBallsRemaining.disconnect(_on_end_of_round)
	EventBus.sigAbortAiming.disconnect(_on_abort_aiming)

func _on_abort_aiming():
	next_state = idle_state
	
func _on_end_of_round():
	next_state = move_bricks_state
	
func process_frame(delta: float) -> State:
	elapsed += delta
	if elapsed > 0.2 and get_tree().get_node_count_in_group("Balls") == 0:
		EventBus.sigNoBallsRemaining.emit()
	return next_state

func process_input(event: InputEvent) -> State:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if game_area.get_rect().has_point(game_area.to_local(event.position)):
				if speed_factor > 9:
					speed_factor += 5
				elif speed_factor > 2.5:
					speed_factor += 1
				else:
					speed_factor += 0.5
				EventBus.sigSpeedFactorChanged.emit(speed_factor)
				for ball in get_tree().get_nodes_in_group("Balls"):
					ball.speed_up(speed_factor)
	return null
