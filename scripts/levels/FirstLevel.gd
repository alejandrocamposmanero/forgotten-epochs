extends Node2D

@onready
var save_point = $save_point

func _ready() -> void:
	if !Data.level_files.has("lvl1"):
		Data.level_files["lvl1"] = "res://scenes/levels/first_level.tscn"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and Data.can_save:
		save_point.save_level("lvl1")

func _on_to_tutorial_body_entered(body: Node2D) -> void:
	if body is Player:
		Data.level_changed = true
		$player.position.x += 32
		Global.game_controller.save_last_level_position("lvl1->lvl0", $player.position)
		Global.game_controller.change_2d_scene("res://scenes/levels/tutorial.tscn")

func _on_to_second_level_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.game_controller.change_2d_scene("")
		
