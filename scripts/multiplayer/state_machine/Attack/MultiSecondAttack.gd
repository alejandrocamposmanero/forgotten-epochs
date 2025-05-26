extends MultiplayerState

@onready 
var collision: CollisionPolygon2D = $"../../sword_collision/attack2"

@export
var attack3 : MultiplayerState
@export
var jump_attack : MultiplayerState
@export
var idle : MultiplayerState
@export
var attack_buffer_time : float = 0.1

var attack_buffer_timer : float

func enter() -> void:
	super()
	parent.sword_visible()
	collision.set_deferred("disabled", false)
	attack_buffer_timer = attack_buffer_time
	parent.attack_number = 2
	parent.attacking = true

func process_input() -> MultiplayerState: 
	if parent.do_attack:
		parent.do_attack = false
		attack_buffer_timer = attack_buffer_time
	return null

func process_frame(delta: float)-> MultiplayerState:
	attack_buffer_timer -= delta
	return null

func process_physics(_delta: float) -> MultiplayerState:
	if !parent.attacking:
		if attack_buffer_timer > 0:
			if parent._is_on_floor:
				return attack3
			else:
				return jump_attack
		return idle
	return null

func _on_animation_attack2_finished() -> void:
	parent.attacking = false
	if parent.sword_animation.animation == "attack2" or parent.sword_animation.animation == "fire_attack2":
		collision.set_deferred("disabled", true)
