extends MultiplayerState
class_name MultiplayerIdle

@export
var jump_state: MultiplayerState
@export
var fall_state: MultiplayerState
@export
var move_state: MultiplayerState
@export
var dash_state: MultiplayerState
@export
var transform : MultiplayerState

func enter() -> void:
	super()
	parent.jump_number = 0
	parent.velocity.x = 0

func process_input() -> MultiplayerState:
	if parent.do_jump and parent._is_on_floor and !parent.attacking:
		parent.do_jump = false
		return jump_state
	if move_component.direction != 0:
		return move_state
	if parent.do_dash and parent.can_dash:
		parent.do_dash = false
		return dash_state
	if parent.do_transform and parent._is_on_floor:
		parent.do_transform = false
		return transform
	return null

func process_physics(delta: float) -> MultiplayerState:
	if !parent.dead:
		parent.can_dash = !parent.is_dash_cooldown
		parent.velocity.y += gravity * delta
		parent.move_and_slide()
		
		if !parent._is_on_floor:
			return fall_state
	return null
