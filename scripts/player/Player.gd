class_name Player
extends CharacterBody2D

@onready
var animation := $animation
@onready
var state_machine := $state_machine
@onready
var move_component := $move_component

var jump_number = 0

func _ready() -> void:
	state_machine.init(self, animation, move_component)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
