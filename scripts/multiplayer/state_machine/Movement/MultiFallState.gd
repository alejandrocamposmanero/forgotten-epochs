extends MultiplayerState

@export_category("States")
@export
var double_jump_state: MultiplayerState
@export
var idle_state: MultiplayerState
@export
var move_state: MultiplayerState
@export
var dash_state: MultiplayerState
@export
var transform_state : MultiplayerState
@export
var jump_state : MultiplayerState

@export_category("Others")
@export
var jump_buffer_time : float = 0.1
@export
var coyote_time : float = 0.1

var coyote_timer : float = 0
var jump_buffer_timer : float

func enter() -> void:
	super()
	coyote_timer = coyote_time
	jump_buffer_timer = 0

func process_input() -> MultiplayerState:
	if parent.do_jump and coyote_timer > 0 and parent.jump_number < 1:
		parent.do_jump = false
		return jump_state
	if parent.do_jump and parent.jump_number < 2 and !parent.attacking:
		parent.do_jump = false
		return double_jump_state
	if parent.do_dash and parent.can_dash:
		parent.do_dash = false
		return dash_state
	if parent.do_transform and parent._is_on_floor:
		parent.do_transform = false
		return transform_state
	if parent.do_jump:
		jump_buffer_timer = jump_buffer_time
	return null

func process_frame(delta: float) -> MultiplayerState:
	jump_buffer_timer -= delta
	coyote_timer -= delta
	return null

func process_physics(delta: float) -> MultiplayerState:
	if !parent.dead:
		parent.velocity.y += gravity * delta
		
		var direction = move_component.direction * move_speed
		if direction != 0:
			parent.animation.flip_h = direction < 0
		parent.velocity.x = direction
		parent.move_and_slide()
		
		if parent._is_on_floor:
			if jump_buffer_timer > 0:
				return jump_state
			if direction != 0:
				return move_state
			return idle_state
		
	return null
