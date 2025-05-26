extends Node
class_name SceneTransition

@export
var background: ColorRect 
@export
var animation_player : AnimationPlayer

func transitioning() -> void:
	background.color = Color(0,0,0)

func transition(animation: String, seconds: float) -> void:
	animation_player.play(animation, -1.0, 1 / seconds)

func transition_done() -> void:
	background.color = Color(0,0,0,0)
