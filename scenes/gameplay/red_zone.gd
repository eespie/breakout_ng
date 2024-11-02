extends Sprite2D

var tween

var offset_start = 1413

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigNextLevel.connect(_on_next_level)

func _on_next_level(_level : int):
	var height = GameManager.get_number_of_brick_lines()
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, "offset", Vector2(0, offset_start - 122 * height), 1.0)
