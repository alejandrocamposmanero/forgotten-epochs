extends Node
class_name Enemy

@export_category("statistics")
@export
var health: int
@export
var speed: float
@export
var damage: int

func receive_damage(damage_done: int) -> void:
	health -= damage_done
