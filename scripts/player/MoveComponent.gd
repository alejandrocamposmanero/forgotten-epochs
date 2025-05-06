extends Node

@onready 
var player: Player = $".."


func get_movement_direction() -> float:
	if player.dead:
		return 0
	return Input.get_axis("move_left", "move_right")

func wants_jump() -> bool:
	if player.dead:
		return false
	return Input.is_action_just_pressed("jump")

func wants_dash() -> bool:
	if player.dead:
		return false
	return Input.is_action_just_pressed("dash")

func wants_basic_attack() -> bool:
	if player.dead:
		return false
	return Input.is_action_just_pressed("basic_attack")

func wants_magic_attack() -> bool:
	if player.dead:
		return false
	return Input.is_action_just_pressed("magic_attack")

func wants_transform() -> bool:
	if player.dead:
		return false
	return Input.is_action_just_pressed("transform")
