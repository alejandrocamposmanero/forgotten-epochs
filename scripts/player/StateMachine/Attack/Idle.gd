extends State

@export
var attack1 : State
@export
var jump_attack : State

func enter() -> void:
	super()
	parent.attack_number = 0
	parent.sword_invisible()

func process_input() -> State:
	if move_component.wants_basic_attack() and parent.is_on_floor():
		return attack1
	if move_component.wants_basic_attack() and !parent.is_on_floor():
		return jump_attack
	return null
