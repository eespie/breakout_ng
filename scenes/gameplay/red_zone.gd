extends Sprite2D

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigNextLevel.connect(_on_next_level)
	
func _on_next_level(level : int):
	if level > 0 and level % 50 == 0:
		if tween:
			tween.kill
		tween = get_tree().create_tween()
		tween.tween_property(self, "offset", Vector2(0, get_offset().y - 122), 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
