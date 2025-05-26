extends MultiplayerState

@onready 
var collision: CollisionShape2D = $"../../sword_collision/jump_attack"

@export
var idle : MultiplayerState
@export
var attack1 : MultiplayerState

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

func exit() -> void:
	super()
	collision.set_deferred("disabled", true)
	parent.attacking = false

func process_input() -> MultiplayerState: 
	if parent.do_attack:
		parent.do_attack = false
		attack_buffer_timer = attack_buffer_time
	return null

func process_frame(delta: float)-> MultiplayerState:
	attack_buffer_timer -= delta
	return null

func process_physics(_delta: float) -> MultiplayerState:
	if parent._is_on_floor:
		if attack_buffer_time > 0:
			return attack1
		return idle
	return null

func _on_animation_jump_attack_finished() -> void:
	parent.attacking = false
	if parent.sword_animation.animation == "jump_attack" or parent.sword_animation.animation == "fire_jump_attack":
		collision.set_deferred("disabled", true)
