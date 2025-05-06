extends State
class_name DeathState

func enter() -> void:
	super()
	parent.dead = true
