extends MoveState

@export
var move_state: State

@export
var dash_time: float = 1.0

var timer := 0.0
var direction := 1.0

func enter() -> void:
	super()
	timer = dash_time
	
	if parent.animation.flip_h:
		direction = -1
	else:
		direction = 1

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	timer -= delta
	if timer <= 0.0:
		if super.get_movement_input() != 0.0:
			return move_state
		return idle_state
	return super(delta)

func get_movement_input() -> float:
	return direction

func get_jump() -> bool:
	return false

func get_dash() -> bool:
	return false
