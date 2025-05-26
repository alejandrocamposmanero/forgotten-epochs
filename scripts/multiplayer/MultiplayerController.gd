class_name MultiplayerPlayer
extends CharacterBody2D

signal player_death

@onready
var animation := $animation
@onready 
var sword_animation := $sword_animation
@onready
var move_state_machine := $move_state_machine
@onready 
var attack_state_machine := $attack_state_machine
@onready
var move_component := %InputSynchronizer
@onready
var dash_cooldown := $dash_cooldown

@export
var death_state: State
@export
var hit_state: State

@export
var transformed := false
@export
var damage : int = 10
@export
var health: int = 100
@export
var mana: float = 100

var attack_number := 0
var jump_number := 0
var dashing := false
var can_dash := true
var is_dash_cooldown := false
var dead := false
var attacking := false

var direction : float = 1
var do_jump := false
var do_dash := false
var do_transform := false
var do_attack := false
var _is_on_floor := true

@export
var player_id := 1:
	set(id):
		player_id = id
		%InputSynchronizer.set_multiplayer_authority(id)

func _ready() -> void:
	if multiplayer.get_unique_id() == player_id:
		$Camera2D.make_current()
	else:
		$Camera2D.enabled = false
	transformed = Data.transformed
	dead = false
	move_state_machine.init(self, animation, move_component)
	attack_state_machine.init(self, sword_animation, move_component)

func _apply_animations(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if multiplayer.is_server():
		_is_on_floor = is_on_floor()
		move_state_machine.process_input()
		attack_state_machine.process_input()
		move_state_machine.process_physics(delta)
		attack_state_machine.process_physics(delta)
		Data.transformed = transformed
		if transformed:
			Data.player_mana -= delta

func sword_visible() -> void:
	sword_animation.visible = true
	animation.visible = false

func sword_invisible() -> void:
	sword_animation.visible = false
	animation.visible = true

func receive_damage(damage_done: int) -> void:
	health -= damage_done
	if health <= 0:
		move_state_machine.change_state(death_state)
	else:
		move_state_machine.change_state(hit_state)

func _process(delta: float) -> void:
	if multiplayer.is_server():
		move_state_machine.process_frame(delta)
		attack_state_machine.process_frame(delta)
		sword_animation.flip_h = animation.flip_h
		Data.player_health = health
		Data.player_mana = mana

func _on_dash_cooldown_timeout() -> void:
	is_dash_cooldown = false

func _on_animation_death_finished() -> void:
	player_death.emit()
