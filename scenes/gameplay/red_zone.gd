extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigNextLevel.connect(_on_next_level)
	
func _on_next_level(level : int):
	if level > 0 and level % 50 == 0:
		position.y -= 122

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
