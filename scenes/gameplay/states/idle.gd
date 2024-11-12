extends "res://state_machine/state.gd"

@export var aim_state : State
@export var level_label: Label
@export var score_label: Label
@export var t_button: TextureRect
@export var f_button: TextureRect
@export var b_button: TextureRect

var game_area : Sprite2D

func enter() -> void:
	# Store the game area to restrict the aiming
	for bg in get_tree().get_nodes_in_group("GameArea"):
		game_area = bg

func process_input(event: InputEvent) -> State:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if game_area.get_rect().has_point(game_area.to_local(event.position)):
				return aim_state
				
			if is_hit(level_label, event):
				Game.change_scene_to_file("res://scenes/menu/menu.tscn")
				
			if is_hit(score_label, event):
				Game.change_scene_to_file("res://scenes/menu/store/store.tscn")
				
			if t_button.count == 0 and is_hit(t_button, event):
				Game.change_scene_to_file("res://scenes/menu/store/store.tscn")
			
			if f_button.count == 0 and is_hit(f_button, event):
				Game.change_scene_to_file("res://scenes/menu/store/store.tscn")
				
			if b_button.count == 0 and is_hit(b_button, event):
				Game.change_scene_to_file("res://scenes/menu/store/store.tscn")
		
	# Not relevant
	return null

func is_hit(label: Control, event: InputEvent) -> bool:
	return label.get_rect().has_point(label.position + event.global_position - label.global_position)
	
