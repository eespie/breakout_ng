extends HBoxContainer

@onready var label = $ToxicButtons


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigEnterState.connect(_on_enter_state)
	EventBus.sigExitState.connect(_on_exit_state)

func _on_enter_state(state : String):
	if state == "Idle":
		show()

func _on_exit_state(state : String):
	if state == "Aim":
		hide()
