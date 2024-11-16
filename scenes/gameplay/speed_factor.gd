extends Label

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigSpeedFactorChanged.connect(_on_speed_factor_changed)

func _on_speed_factor_changed(speed_factor : float):
	if speed_factor == 1.0:
		return
	set_text("%.1fX" % speed_factor)
	if tween:
		tween.kill()
	show()
	set_modulate(Color.WHITE)
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0)
