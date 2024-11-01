extends "res://state_machine/state.gd"


func process_input(event: InputEvent) -> State:
	if event is InputEventMouseButton:
		if event.is_pressed():
			Game.change_scene_to_file("res://scenes/menu/menu.tscn")
	
	return null
