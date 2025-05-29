extends CharacterBody2D
class_name Enemy

@export_category("statistics")
@export
var max_health: int

@export
var speed: float
@export
var damage: int

var health: int
var dead: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func receive_damage(damage_done: int) -> void:
	health -= damage_done
	print("vida: %s" %health)
	if health <= 0:
		dead = true
