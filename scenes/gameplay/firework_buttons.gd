extends TextureRect

@onready var label = $FireworkCount
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.sigLoadPermanentDataDone.connect(_on_data_loaded)
	EventBus.sigBonusesUpdated.connect(_on_data_loaded)

func _get_drag_data(at_position):
	if count == 0:
		return null
	
	var drag_preview := Control.new()
	var texture_rect := TextureRect.new()
	texture_rect.modulate = Color(1, 1, 1, 0.75)
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_rect.set_texture(get_texture())
	texture_rect.custom_minimum_size = Vector2(90, 120)
	# center-align the texture_rect, so that mouse pointer is in its middle
	texture_rect.position = -0.5 * texture_rect.custom_minimum_size
	drag_preview.add_child(texture_rect)
	set_drag_preview(drag_preview)
	
	return 'Firework'

func _on_data_loaded():
	count = 0
	if GameManager.items.has('Firework'):
		count = GameManager.items['Firework']
	
	label.set_text(str(count))
