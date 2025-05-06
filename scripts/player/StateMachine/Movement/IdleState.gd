extends State
class_name Idle

@export
var jump_state: State
@export
var fall_state: State
@export
var move_state: State
@export
var dash_state: State
@export
var transform : State

func enter() -> void:
	super()
	parent.jump_number = 0
	parent.velocity.x = 0

func process_input() -> State:
	if move_component.wants_jump() and parent.is_on_floor():
		return jump_state
	if move_component.get_movement_direction() != 0:
		return move_state
	if move_component.wants_dash() and parent.can_dash:
		return dash_state
	if move_component.wants_transform() and parent.is_on_floor():
		return transform
	return null

func process_physics(delta: float) -> State:
	if !parent.dead:
		parent.can_dash = !parent.is_dash_cooldown
		parent.velocity.y += gravity * delta
		parent.move_and_slide()
		
		if !parent.is_on_floor():
			return fall_state
	return null
