class_name Player
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
var move_component := $input_component
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
var health: int
@export
var mana: float

var attack_number := 0
var jump_number := 0
var dashing := false
var can_dash := true
var is_dash_cooldown := false
var dead := false
var attacking := false

var collisions_flipped := false

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
	
func _ready() -> void:
	health = Data.player_health
	mana = Data.player_mana
	transformed = Data.transformed
	dead = false
	move_state_machine.init(self, animation, move_component)
	attack_state_machine.init(self, sword_animation, move_component)

func _unhandled_input(_event: InputEvent) -> void:
	move_state_machine.process_input()
	attack_state_machine.process_input()

func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)
	attack_state_machine.process_physics(delta)
	Data.transformed = transformed
	if transformed:
		mana -= delta

func _process(delta: float) -> void:
	move_state_machine.process_frame(delta)
	attack_state_machine.process_frame(delta)
	sword_animation.flip_h = animation.flip_h
	if animation.flip_h and !collisions_flipped:
		flip_collisions()
	elif !animation.flip_h and collisions_flipped:
		flip_collisions()
	Data.player_health = health
	Data.player_mana = mana
	if Data.can_save:
		Data.player_posx = position.x
		Data.player_posy = position.y
	if Data.loaded_game:
		position.x = Data.player_posx
		position.y = Data.player_posy
		Data.loaded_game = false

func _on_dash_cooldown_timeout() -> void:
	is_dash_cooldown = false

func _on_animation_death_finished() -> void:
	player_death.emit()

func flip_collisions():
	$sword_collision/attack1.position.x *= -1
	$sword_collision/jump_attack.position.x *= -1
	collisions_flipped = !collisions_flipped

func _on_sword_collision_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.receive_damage(damage)
		print("aaaa")
