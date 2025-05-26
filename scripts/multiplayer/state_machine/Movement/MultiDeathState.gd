extends MultiplayerState
class_name MultiplayerDeathState

func enter() -> void:
	super()
	parent.dead = true
