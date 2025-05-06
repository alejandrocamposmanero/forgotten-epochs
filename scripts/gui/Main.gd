extends Control

func _on_play_pressed() -> void:
	Global.game_controller.change_2d_scene("res://scenes/maps/tutorial.tscn")
	Global.game_controller.change_gui_scene("res://scenes/gui/hud.tscn")

func _on_options_pressed() -> void:
	print("Vas a las opciones")

func _on_quit_pressed() -> void:
	get_tree().quit()
