extends MultiplayerState

@export
var attack1 : MultiplayerState
@export
var jump_attack : MultiplayerState

func enter() -> void:
	super()
	parent.attack_number = 0
	parent.sword_invisible()

func process_input() -> MultiplayerState:
	if parent.do_attack and parent._is_on_floor:
		parent.do_attack = false
		return attack1
	if parent.do_attack and !parent._is_on_floor:
		parent.do_attack = false
		return jump_attack
	return null
