extends State

@onready 
var collision: CollisionShape2D = $"../../sword_collision/attack1"

@export
var attack2 : State
@export
var jump_attack : State
@export
var idle : State

@export
var attack_buffer_time : float = 0.1

var attack_buffer_timer : float
var attack_finished : bool = false

func enter() -> void:
	super()
	parent.sword_visible()
	collision.set_deferred("disabled", false)
	parent.attacking = true
	parent.attack_number = 1

func process_input() -> State: 
	if move_component.wants_basic_attack():
		attack_buffer_timer = attack_buffer_time
	return null

func process_frame(delta: float) -> State:
	attack_buffer_timer -= delta
	return null

func process_physics(_delta: float) -> State:
	if !parent.attacking:
		if attack_buffer_timer > 0:
			if parent.is_on_floor():
				return attack2
			else:
				return jump_attack
		return idle
	return null


func _on_animation_attack1_finished() -> void:
	parent.attacking = false
	if parent.sword_animation.animation == "attack1" or parent.sword_animation.animation == "fire_attack1":
		collision.set_deferred("disabled", true)
		
