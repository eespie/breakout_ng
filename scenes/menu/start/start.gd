extends Control

@onready var container = $MarginContainer

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_tree().create_tween()
	tween.tween_property(container, "modulate", Color.WHITE, 0.3)
	tween.tween_property(container, "modulate", Color.WHITE, 3)
	tween.tween_callback(start_menu)
	
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		tween.kill()
		start_menu()

func start_menu():
	Game.change_scene_to_file("res://scenes/menu/menu.tscn")
