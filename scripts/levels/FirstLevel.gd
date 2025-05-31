extends Node2D

@onready
var save_point = $save_point
@onready 
var player: Player = $player

func _ready() -> void:
	if !Data.level_files.has("lvl1"):
		Data.level_files["lvl1"] = "res://scenes/levels/first_level.tscn"
	if Data.level_changed:
		player.position = Data.level_last_position["lvl1->lvl2"]
		Data.level_changed = false
		player.animation.flip_h = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and Data.can_save:
		save_point.save_level("lvl1")

func _on_to_tutorial_body_entered(body: Node2D) -> void:
	if body is Player:
		Data.level_changed = true
		$player.position.x += 32
		Global.game_controller.save_last_level_position("lvl1->lvl0", $player.position)
		Global.game_controller.start_transition()
		Global.game_controller.change_2d_scene("res://scenes/levels/tutorial.tscn", true)
		Global.game_controller.end_transition()

func _on_to_second_level_body_entered(body: Node2D) -> void:
	if body is Player:
		Data.level_changed = true
		player.position.x -= 32
		Global.game_controller.save_last_level_position("lvl1->lvl2", $player.position)
		Global.game_controller.start_transition()
		Global.game_controller.change_2d_scene("res://scenes/levels/boss_level.tscn", true)
		Global.game_controller.end_transition()
		
