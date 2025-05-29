extends Idle
class_name HitState

@export
var idle: State

var hit_time : float = 0.15
var hit_done : bool = false

func enter() -> void:
	super()
	hit_done = false
	
func process_input() -> State:
	if hit_done:
		super()
	return null

func _on_animation_hit_finished() -> void:
	if parent.animation.animation == "hit" or parent.animation.animation == "fire_hit":
		hit_done = true
		parent.move_state_machine.change_state(idle)
