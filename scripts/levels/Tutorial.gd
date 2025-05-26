extends Node2D

@onready
var player : Player = $player
@onready 
var save_point: Node2D = $save_point

func _ready() -> void:
	if !Data.level_files.has("lvl0"):
		Data.level_files["lvl0"] = "res://scenes/levels/tutorial.tscn"
	if Data.level_changed:
		player.position = Data.level_last_position["lvl0->lvl1"]
		Data.level_changed = false
		player.animation.flip_h = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and Data.can_save:
		save_point.save_level("lvl0")

func _on_level_change_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.game_controller.start_transition()
		Global.game_controller.change_2d_scene("res://scenes/levels/first_level.tscn", true)
		Global.game_controller.end_transition()
		player.position.x -= 32
		Global.game_controller.save_last_level_position("lvl0->lvl1", player.position)
		
