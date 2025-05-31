extends Node

@onready 
var host: Button = $CanvasLayer/PanelContainer/VBoxContainer/host
@onready 
var join: Button = $CanvasLayer/PanelContainer/VBoxContainer/join

func _ready() -> void:
	host.grab_focus()

func _on_host_pressed() -> void:
	Global.game_controller.start_transition()
	Global.game_controller.change_2d_scene("res://scenes/multiplayer/multiplayer_level.tscn")
	Global.game_controller.change_gui_scene("")
	Global.game_controller.end_transition()
	MultiplayerManager.become_host()

func _on_join_pressed() -> void:
	Global.game_controller.start_transition()
	Global.game_controller.change_2d_scene("res://scenes/multiplayer/multiplayer_level.tscn")
	Global.game_controller.change_gui_scene("")
	Global.game_controller.end_transition()
	MultiplayerManager.join_host()

func _on_back_pressed() -> void:
	Global.game_controller.change_gui_scene("res://scenes/gui/main_ui.tscn")
