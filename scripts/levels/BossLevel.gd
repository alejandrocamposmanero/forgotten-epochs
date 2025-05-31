extends Node2D

func _ready() -> void:
	if !Data.level_files.has("lvl2"):
		Data.level_files["lvl2"] = "res://scenes/levels/boss_level.tscn"

func _on_to_first_level_body_entered(body: Node2D) -> void:
	if body is Player:
		Data.level_changed = true
		$player.position.x += 32
		Global.game_controller.save_last_level_position("lvl2->lvl1", $player.position)
		Global.game_controller.start_transition()
		Global.game_controller.change_2d_scene("res://scenes/levels/first_level.tscn", true)
		Global.game_controller.end_transition()
