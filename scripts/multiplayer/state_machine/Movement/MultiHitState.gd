extends MultiplayerIdle
class_name MultiplayerHitState

@export
var idle: MultiplayerState

var hit_time : float = 0.15
var hitted : bool = false

func enter() -> void:
	super()
	hitted = false
	
func process_input() -> MultiplayerState:
	if hitted:
		super()
	return null
	
func process_physics(delta: float) -> MultiplayerState:
	parent.dead = true
	await(get_tree().create_timer(hit_time).timeout)
	parent.dead = false
	
	parent.can_dash = !parent.is_dash_cooldown
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent._is_on_floor:
		return fall_state
	if hitted:
		return idle
	return null

func _on_animation_hit_finished() -> void:
	if parent.animation.animation == "hit" or parent.animation.animation == "fire_hit":
		hitted = true
	
