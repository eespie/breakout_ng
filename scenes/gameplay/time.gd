extends Label

var elapsed = 0
var last_elapsed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var time = Time.get_datetime_dict_from_system()
	set_text("%2d:%2d:%2d" % [time['hour'], time['minute'], time['second']])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta
	if elapsed - last_elapsed > 1:
		var time = Time.get_datetime_dict_from_system()
		set_text("%02d:%02d:%02d" % [time['hour'], time['minute'], time['second']])
		last_elapsed = elapsed
