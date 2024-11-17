extends Label

var curr_points : float = 0.0
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigScorePointsUpdated.connect(_on_score_updated)

func _on_score_updated():
	if not get_tree():
		return
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, 'curr_points', GameManager.total_points, 0.3)
	
func _process(_delta):
	var points = floori(curr_points)
	if points > 10000:
		points = "%.1fk" % (points / 1000.0)
	else:
		points = str(points)
	set_text(points)
