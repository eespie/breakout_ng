extends Label

var tween : Tween

func _ready():
	EventBus.sigStoreItemPurchased.connect(_on_item_purchased)

func _on_item_purchased(name : String, amount : int):
	set_text("The %s brick has been added
to your inventory" % name)
	if tween:
		tween.kill()
	show()
	set_modulate(Color.WHITE)
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 5.0)
