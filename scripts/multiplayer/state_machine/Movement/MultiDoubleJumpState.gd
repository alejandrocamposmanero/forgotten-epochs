extends MultiplayerState

@export
var fall_state: MultiplayerState
@export
var move_state: MultiplayerState
@export
var idle_state: MultiplayerState
@export
var dash_state: MultiplayerState

@export
var jump_force : float = -400.0

func enter() -> void:
	super()
	parent.jump_number = 2
	parent.velocity.y = jump_force

func process_input() -> MultiplayerState:
	if parent.do_dash and parent.can_dash:
		parent.do_dash = false
		return dash_state
	return null

func process_physics(delta: float) -> MultiplayerState:
	if !parent.dead:
		parent.velocity.y += gravity * delta
		
		if parent.velocity.y > 0:
			return fall_state
		
		var direction = move_component.direction * move_speed
		if direction != 0:
			parent.animation.flip_h = direction < 0
		parent.velocity.x = direction
		parent.move_and_slide()
		
		if parent._is_on_floor:
			if direction != 0:
				return move_state
			return idle_state
		
	return null
