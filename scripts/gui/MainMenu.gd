extends Control

@onready 
var play: Button = $CanvasLayer/PanelContainer/VBoxContainer/Play
@onready 
var load_button: Button = $CanvasLayer/PanelContainer/VBoxContainer/Load

func _ready() -> void:
	play.grab_focus()
	if !FileAccess.file_exists("user://saved_data/savefile.csv"):
		load_button.disabled = true

func _on_play_pressed() -> void:
	Global.game_controller.start_transition()
	Global.game_controller.change_2d_scene("res://scenes/levels/tutorial.tscn")
	Global.game_controller.change_gui_scene("")
	Global.game_controller.end_transition()
	var dir = DirAccess.open("user://")
	if !dir.dir_exists("user://saved_data"):
		dir.make_dir("user://saved_data")
	if dir.file_exists("user://saved_data/savefile.csv"):
		dir.remove("user://saved_data/savefile.csv")
	if dir.file_exists("user://saved_data/levels_last_positions.csv"):
		dir.remove("user://saved_data/levels_last_positions.csv")

func _on_options_pressed() -> void:
	print("Vas a las opciones")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_load_pressed() -> void:
	Global.game_controller.load_game()

func _on_multiplayer_pressed() -> void:
	Global.game_controller.change_gui_scene("res://scenes/gui/multiplayer_ui.tscn")
