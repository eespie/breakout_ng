extends Node2D

@onready
var firework_scn = preload("res://scenes/gameplay/firework/firework.tscn")

func _ready():
	EventBus.sigFireworkStart.connect(_on_firework_start)

func _on_firework_start(pos : Vector2):
	var fwk = firework_scn.instantiate()
	fwk.set_position(pos)
	add_child(fwk)
