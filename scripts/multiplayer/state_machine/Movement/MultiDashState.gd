extends MultiplayerMoveState

@export
var move_state: MultiplayerState

@export
var dash_time: float = 1.0

var dashing := false

var dash_direction := 1.0

func enter() -> void:
	super()
	parent.can_dash = !parent.is_dash_cooldown
	
	if parent.animation.flip_h:
		dash_direction = -1
	else:
		dash_direction = 1

func process_input() -> MultiplayerState:
	return null

func process_physics(_delta: float) -> MultiplayerState:
	
	var direction = dash_direction * move_speed
	
	parent.velocity.y = 0
	parent.velocity.x = direction
	parent.move_and_slide()
	
	dashing = true
	await(get_tree().create_timer(dash_time).timeout)
	dashing = false
	
	if !dashing and !parent.dead:
		parent.dash_cooldown.start()
		parent.is_dash_cooldown = true
		if !parent._is_on_floor:
			return fall_state
		if super.get_movement_input() != 0.0:
			return move_state
		return idle_state
	return null

func get_movement_input() -> float:
	return dash_direction

func get_jump() -> bool:
	return false

func get_dash() -> bool:
	return false
