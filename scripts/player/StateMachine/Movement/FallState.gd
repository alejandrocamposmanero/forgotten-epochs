extends State

@export_category("States")
@export
var double_jump_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var dash_state: State
@export
var transform_state : State
@export
var jump_state : State

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

func process_input() -> State:
	if move_component.wants_jump() and coyote_timer > 0 and parent.jump_number < 1:
		return jump_state
	if move_component.wants_jump() and parent.jump_number < 2 and !parent.attacking:
		return double_jump_state
	if move_component.wants_dash() and parent.can_dash:
		return dash_state
	if move_component.wants_transform() and parent.is_on_floor():
		return transform_state
	if move_component.wants_jump():
		jump_buffer_timer = jump_buffer_time
	return null

func process_frame(delta: float) -> State:
	jump_buffer_timer -= delta
	coyote_timer -= delta
	return null

func process_physics(delta: float) -> State:
	if !parent.dead:
		parent.velocity.y += gravity * delta
		
		var direction = move_component.get_movement_direction() * move_speed
		if direction != 0:
			parent.animation.flip_h = direction < 0
		parent.velocity.x = direction
		parent.move_and_slide()
		
		if parent.is_on_floor():
			if jump_buffer_timer > 0:
				return jump_state
			if direction != 0:
				return move_state
			return idle_state
		
	return null
