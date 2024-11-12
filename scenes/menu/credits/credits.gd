extends Control


func _on_back_button_pressed():
	var params = {
		"show_progress_bar": false
	}
	Game.back()
