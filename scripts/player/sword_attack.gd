extends Area2D

@export
var parent : Player

func _on_area_entered(area: Area2D) -> void:
	print("funciona")
	area.receive_damage(parent.damage)
