extends Label

var is_active: bool
var timer: float

# Called when the node enters the scene tree for the first time.
func _ready():
	is_active = false
	timer = 0
	EventBus.sigBallShoot.connect(_on_start_timer)
	EventBus.sigNoBallsRemaining.connect(_on_stop_timer)

func _on_start_timer():
	is_active = true
	timer = 0
	
func _on_stop_timer():
	is_active = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		timer += delta
		
	var hours = floori(timer / 3600)
	var minutes = floori((timer - 3600 * hours) / 60)
	var seconds = floori(timer - 3600 * hours - 60 * minutes)
	
	set_text("%02d:%02d:%02d" % [hours, minutes, seconds])
	
