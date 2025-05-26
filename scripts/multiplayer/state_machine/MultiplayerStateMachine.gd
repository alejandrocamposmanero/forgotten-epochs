class_name MultiplayerStateMachine
extends Node

@export
var initial_state : MultiplayerState

var current_state : MultiplayerState

func init(parent: MultiplayerPlayer, animation: AnimatedSprite2D, move_component) -> void:
	for child in get_children():
		child.parent = parent
		child.animation = animation
		child.move_component = move_component
	
	change_state(initial_state)

func change_state(new_state: MultiplayerState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	@warning_ignore("redundant_await")
	var new_state = await current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input() -> void:
	var new_state = current_state.process_input()
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
