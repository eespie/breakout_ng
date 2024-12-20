extends Node

@export var initial_state: State
@export var from_scratch_state: State
@export var continue_starting_state: State

var current_state: State

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init() -> void:
	# Initialize to the default state
	change_state(initial_state)
	
func start_game():
	if GameManager.level == 0:
		change_state(from_scratch_state)
	else:
		change_state(continue_starting_state)
		
# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	print("Changing to state: ", new_state)
	if current_state:
		current_state.exit()
		EventBus.sigExitState.emit(current_state.get_name())

	current_state = new_state
	current_state.enter()
	EventBus.sigEnterState.emit(current_state.get_name())
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
