extends Label

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigReplayBonusUpdated.connect(_on_replay_bonus_updated)

func _on_replay_bonus_updated(bonus : int):
	if bonus > 0:
		if tween:
			tween.kill()
		show()
		set_modulate(Color.WHITE)
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 1.5)
		tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
