extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var double_jump_state: State

@export
var jump_force: float = -400

func enter() -> void:
	super()
	parent.jump_number = 1
	parent.velocity.y = jump_force

func process_input(event: InputEvent) -> State:
	if move_component.wants_jump() and !parent.is_on_floor():
		return double_jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return fall_state
	
	var direction = move_component.get_movement_direction() * move_speed
	if direction != 0:
		parent.animation.flip_h = direction < 0
	parent.velocity.x = direction
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if direction != 0:
			return move_state
		return idle_state
	
	return null
