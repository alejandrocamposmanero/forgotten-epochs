extends Area2D

func _on_body_entered(body: Player) -> void:
	Global.game_controller.change_2d_scene("res://scenes/maps/first_level.tscn")
