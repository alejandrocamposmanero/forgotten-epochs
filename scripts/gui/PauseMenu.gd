extends Control

@onready
var resume : Button = $CanvasLayer/PanelContainer/VBoxContainer/Resume
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume.grab_focus()
	get_tree().paused = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = false
		Global.game_controller.change_gui_scene("")

func _on_resume_pressed() -> void:
	get_tree().paused = false
	Global.game_controller.change_gui_scene("")

func _on_options_pressed() -> void:
	print("Vas a las opciones")


func _on_quit_pressed() -> void:
	get_tree().paused = false
	Global.game_controller.change_gui_scene("res://scenes/gui/main_ui.tscn")
	Global.game_controller.change_2d_scene("")
	Global.game_controller.hide_hud()
