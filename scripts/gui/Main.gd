extends Control

@onready 
var play: Button = $CanvasLayer/PanelContainer/VBoxContainer/Play
@onready 
var load: Button = $CanvasLayer/PanelContainer/VBoxContainer/Load

func _ready() -> void:
	play.grab_focus()
	if !FileAccess.file_exists("res://saved_data/savefile.csv"):
		load.disabled = true

func _on_play_pressed() -> void:
	Global.game_controller.change_2d_scene("res://scenes/levels/tutorial.tscn")
	Global.game_controller.change_gui_scene("")
	Global.game_controller.show_hud()
	var dir = DirAccess.open("res://saved_data")
	if dir.file_exists("savefile.csv"):
		dir.remove("savefile.csv")
	if dir.file_exists("levels_last_positions.csv"):
		dir.remove("levels_last_positions.csv")

func _on_options_pressed() -> void:
	print("Vas a las opciones")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_load_pressed() -> void:
	Global.game_controller.load_game()
