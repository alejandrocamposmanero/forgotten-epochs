extends Idle

@export
var idle : State

var transformation_done : bool = false

func enter() -> void:
	super()
	transformation_done = false

func process_input() -> State:
	if transformation_done:
		super()
	return null

func process_physics(delta:float) -> State:
	parent.can_dash = !parent.is_dash_cooldown
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	if transformation_done:
		return idle
	return null

func _on_animation_transform_finished() -> void:
	transformation_done = true
	if parent.animation.animation == "transform" or parent.animation.animation == "fire_transform":
		parent.transformed = !parent.transformed
	
