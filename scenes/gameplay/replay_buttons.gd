extends TextureButton

@export var replay_bonus : int = 0
@onready var replay_cout_label = $ReplayCount

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigBonusAddReplay.connect(_on_replay_added)
	EventBus.sigEnterState.connect(_on_enter_state)
	EventBus.sigExitState.connect(_on_exit_state)
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)

func _on_replay_added(count : int):
	replay_bonus += count
	replay_cout_label.set_text(str(replay_bonus))

func _on_pressed():
	replay_bonus -= 1
	replay_cout_label.set_text(str(replay_bonus))
	# Replay the game
	Game.restart_scene()
	
func _on_enter_state(state : String):
	if state == "Run" and replay_bonus > 0:
		show()
		
func _on_exit_state(state : String):
	hide()
	
func _on_end_of_round():
	var remaining_bricks = get_tree().get_node_count_in_group("Bricks")
		

func save_game():
	var save_dict = {
		"name" : get_path(),
		"replay_bonus" : replay_bonus
	}
	return save_dict

func load_game(node_data):
	replay_bonus = node_data["replay_bonus"]
	replay_cout_label.set_text(str(replay_bonus))
