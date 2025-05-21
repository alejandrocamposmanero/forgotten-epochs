class_name MoveState
extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State
@export
var dash_state: State
@export
var transform_state : State

func process_input() -> State:
	if get_jump() and parent.is_on_floor() and !parent.attacking:
		return jump_state
	if get_dash() and parent.can_dash:
		return dash_state
	if move_component.wants_transform() and parent.is_on_floor():
		return transform_state
	return null

func process_physics(delta: float) -> State:
	if !parent.dead and !parent.attacking:
		parent.can_dash = !parent.is_dash_cooldown
		parent.jump_number = 0
		parent.velocity.y += gravity * delta
		
		var direction = get_movement_input() * move_speed
		
		if direction == 0:
			return idle_state
		
		parent.animation.flip_h = direction < 0
		parent.velocity.x = direction
		parent.move_and_slide()
		
		if !parent.is_on_floor():
			return fall_state
	return null

func get_movement_input() -> float:
	return move_component.get_movement_direction()

func get_jump() -> bool:
	return move_component.wants_jump()

func get_dash() -> bool:
	return move_component.wants_dash()
