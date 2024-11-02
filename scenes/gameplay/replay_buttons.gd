extends TextureButton

@onready var replay_cout_label = $ReplayCount

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEnterState.connect(_on_enter_state)
	EventBus.sigExitState.connect(_on_exit_state)
	EventBus.sigNoBallsRemaining.connect(_on_end_of_round)

func _on_pressed():
	if GameManager.state != "Run":
		return
	# Replay the game
	GameManager.update_replay_bonus(-1)

func _on_enter_state(state : String):
	if state == "Run" and GameManager.replay_bonus > 0:
		replay_cout_label.set_text(str(GameManager.replay_bonus))
		show()
		
func _on_exit_state(state : String):
	if state == "Run":
		hide()
	
func _on_end_of_round():
	var remaining_bricks = get_tree().get_node_count_in_group("Bricks")
	if remaining_bricks == 0:
		GameManager.update_replay_bonus(1 + floori(GameManager.level / 10))
	
