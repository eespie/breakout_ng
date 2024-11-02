extends Control

func _ready():
	# for the wallet
	SaveGame.load_permanent_data()
	


func _on_back_button_pressed():
	var params = {
		"show_progress_bar": false
	}
	Game.change_scene_to_file("res://scenes/menu/menu.tscn", params)
