extends RayCast2D

@export
var aiming_len_factor : float = 2.8

# Ball direction in radian where up is 0, right is PI/2 and left is -PI/2
var ballDir

var aiming_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	set_enabled(false)
	EventBus.sigStopAiming.connect(_on_stop_aiming)
	EventBus.sigAbortAiming.connect(_on_stop_aiming)
	EventBus.sigMouseAiming.connect(_on_aiming)

# mouse moved, so the aiming changes
func _on_aiming(global_aiming_pos: Vector2):
	aiming_pos = to_local(global_aiming_pos) * aiming_len_factor
	set_target_position(aiming_pos)
	var angle = -rad_to_deg(Vector2.ZERO.angle_to_point(target_position))
	if angle < 1 or angle > 179:
		ballDir = null
		set_enabled(false)
		return
	set_enabled(true)
	ballDir = deg_to_rad(90 - angle)

# stop/abort aiming, no more updates
func _on_stop_aiming():
	set_enabled(false)
