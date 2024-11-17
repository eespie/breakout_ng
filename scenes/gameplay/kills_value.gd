extends Label

var kills : float = 0
var initial_bricks : float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigBrickKilled.connect(_on_brick_killed)
	EventBus.sigEnterState.connect(_on_enter_state)
	display()

func _on_brick_killed():
	kills += 1
	display()

func _on_enter_state(state : String):
	if state == "Run":
		initial_bricks = get_tree().get_node_count_in_group("Bricks")
		kills = 0
		display()
		show()

func display() -> void:
	var ratio = 100.0 * kills / initial_bricks
	
	set_text("kills %.0f - %.0f%%" % [kills, ratio])
