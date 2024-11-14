extends Label

var tween : Tween
@onready var coins_earned_label = $CoinsEarned

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigReplayBonusUpdated.connect(_on_replay_bonus_updated)
	EventBus.sigAddScorePoints.connect(_on_points_added)
	set_modulate(Color.TRANSPARENT)

func _on_replay_bonus_updated(bonus : int):
	if bonus > 0:
		if tween:
			tween.kill()
		set_modulate(Color.WHITE)
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 1.5)
		tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)

func _on_points_added(points: int):
	coins_earned_label.set_text("%d coins earned" % points)
