extends Node


func _process(delta: float) -> void:
	$key.visible = Data.can_save

func save_level(level: String) -> void:
	Global.game_controller.save_game(level)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Data.can_save = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		Data.can_save = false
