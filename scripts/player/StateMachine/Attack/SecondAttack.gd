extends State

@onready 
var collision_right: CollisionPolygon2D = $"../../sword_collision/attack2_right"
@onready 
var collision_left: CollisionPolygon2D = $"../../sword_collision/attack2_left"

@export
var attack3 : State
@export
var jump_attack : State
@export
var idle : State
@export
var attack_buffer_time : float = 0.1

var attack_buffer_timer : float

func enter() -> void:
	super()
	parent.sword_visible()
	if parent.animation.flip_h:
		collision_left.set_deferred("disabled", false)
	else:
		collision_right.set_deferred("disabled", false)
	attack_buffer_timer = attack_buffer_time
	parent.attack_number = 2
	parent.attacking = true

func process_input() -> State: 
	if move_component.wants_basic_attack():
		attack_buffer_timer = attack_buffer_time
	return null

func process_frame(delta: float)-> State:
	attack_buffer_timer -= delta
	return null

func process_physics(_delta: float) -> State:
	if !parent.attacking:
		if attack_buffer_timer > 0:
			if parent.is_on_floor():
				return attack3
			else:
				return jump_attack
		return idle
	return null

func _on_animation_attack2_finished() -> void:
	parent.attacking = false
	if parent.sword_animation.animation == "attack2" or parent.sword_animation.animation == "fire_attack2":
		collision_right.set_deferred("disabled", true)
		collision_left.set_deferred("disabled", true)
