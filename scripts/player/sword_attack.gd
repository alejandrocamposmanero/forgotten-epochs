extends Area2D

@export
var parent : Player

func _on_area_entered(area: Enemy) -> void:
	print("funciona")
	area.receive_damage(parent.damage)
