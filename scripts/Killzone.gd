extends Area2D

func _on_body_entered(body: Player) -> void:
	body.receive_damage(10)

func _on_player_player_death() -> void:
	if Data.player_health <= 0:
		Global.game_controller.change_2d_scene("res://scenes/maps/tutorial.tscn")
 
