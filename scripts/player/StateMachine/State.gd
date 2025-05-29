class_name State
extends Node

@export
var animation_name: String
@export
var fire_animation_name: String
@export
var move_speed: float = 200

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: Player
var animation: AnimatedSprite2D
var move_component

func enter() -> void:
	if parent.transformed:
		animation.play(fire_animation_name)
	else:
		animation.play(animation_name)

func exit() -> void:
	pass

func process_input() -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
