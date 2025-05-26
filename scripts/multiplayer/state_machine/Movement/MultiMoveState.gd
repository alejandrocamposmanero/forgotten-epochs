class_name MultiplayerMoveState
extends MultiplayerState

@export
var fall_state: MultiplayerState
@export
var idle_state: MultiplayerState
@export
var jump_state: MultiplayerState
@export
var dash_state: MultiplayerState
@export
var transform_state : MultiplayerState

func process_input() -> MultiplayerState:
	if get_jump() and parent._is_on_floor and !parent.attacking:
		parent.do_jump = false
		return jump_state
	if get_dash() and parent.can_dash:
		parent.do_dash = false
		return dash_state
	if parent.do_transform and parent._is_on_floor:
		parent.do_transform = false
		return transform_state
	return null

func process_physics(delta: float) -> MultiplayerState:
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
		
		if !parent._is_on_floor:
			return fall_state
	return null

func get_movement_input() -> float:
	return move_component.direction

func get_jump() -> bool:
	return parent.do_jump

func get_dash() -> bool:
	return parent.do_dash
