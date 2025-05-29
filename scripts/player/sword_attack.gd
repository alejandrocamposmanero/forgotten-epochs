extends Area2D

@export
var parent : Player

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.receive_damage(parent.damage)
		print("aaaa")
