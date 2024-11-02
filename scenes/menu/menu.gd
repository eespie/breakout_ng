extends Control

@onready var btn_play = $MarginContainer/Control/VBoxContainer/PlayButton
@onready var btn_exit = $MarginContainer/Control/VBoxContainer/ExitButton


func _ready():
	# needed for gamepads to work
	btn_play.grab_focus()
	if OS.has_feature('web'):
		btn_exit.queue_free() # exit button dosn't make sense on HTML5


func _on_PlayButton_pressed() -> void:
	var params = {
		"show_progress_bar": false,
	}
	Game.change_scene_to_file("res://scenes/gameplay/gameplay.tscn", params)

func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		await transitions.anim.animation_finished
		await get_tree().create_timer(0.3).timeout
	get_tree().quit()

func _on_credits_button_pressed():
	var params = {
		"show_progress_bar": false
	}
	Game.change_scene_to_file("res://scenes/menu/credits/credits.tscn", params)


func _on_store_button_pressed():
	var params = {
		"show_progress_bar": false
	}
	Game.change_scene_to_file("res://scenes/menu/store/store.tscn", params)
