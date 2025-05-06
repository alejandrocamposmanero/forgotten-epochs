extends State

@export
var idle: State

func enter() -> void:
	super()
	parent.attack_number = 1

func process_physics(delta: float) -> State:
	print("attacking in the air")
	return idle
