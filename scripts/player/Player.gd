class_name Player
extends CharacterBody2D

signal player_death

@onready
var animation := $animation
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
var total_health : int = 100
@export
var total_mana : int = 100
@export
var damage : int = 10

var attack_number := 0
var jump_number := 0
var dashing := false
var can_dash := true
var is_dash_cooldown := false
var dead := false
var attacking := false

func receive_damage(damage_done: int) -> void:
	Data.player_health -= damage_done
	if Data.player_health <= 0:
		move_state_machine.change_state(death_state)
	else:
		move_state_machine.change_state(hit_state)
	
func _ready() -> void:
	Data.player_health = total_health
	Data.player_mana = total_mana
	dead = false
	move_state_machine.init(self, animation, move_component)
	attack_state_machine.init(self, animation, move_component)

func _unhandled_input(_event: InputEvent) -> void:
	move_state_machine.process_input()
	attack_state_machine.process_input()

func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)
	attack_state_machine.process_physics(delta)
	if transformed:
		Data.player_mana -= delta

func _process(delta: float) -> void:
	move_state_machine.process_frame(delta)
	attack_state_machine.process_frame(delta)

func _on_dash_cooldown_timeout() -> void:
	is_dash_cooldown = false

func _on_animation_death_finished() -> void:
	player_death.emit()
