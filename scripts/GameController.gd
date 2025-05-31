class_name GameController 
extends Node

@export 
var world_2d: Node2D
@export 
var gui: Control

@onready 
var level_transition: Control = $level_transition

var current_2d_scene: Node2D
var current_gui_scene: Control

var previous_2d_scenes := {}

func _ready() -> void:
	Global.game_controller = self
	current_gui_scene = $gui/UI

func start_transition() -> void:
	level_transition.visible = true
	level_transition.transition("fade out", 1)

func end_transition() -> void:
	level_transition.transition("fade in", 1.5)

func change_gui_scene(new_scene: String, deferred: bool = false, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.call_deferred("remove_child", current_gui_scene)
	if new_scene != "":
		var new = load(new_scene).instantiate() as Control
		if deferred:
			gui.call_deferred("add_child", new)
		else:
			gui.add_child(new)
		current_gui_scene = new
	else:
		current_gui_scene = null

func change_2d_scene(new_scene: String, deferred: bool = false, delete: bool = true, keep_running: bool = false) -> void:
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			previous_2d_scenes[current_2d_scene.name] = current_2d_scene
			current_2d_scene.visible = false
		else:
			world_2d.call_deferred("remove_child", current_2d_scene)
	if new_scene != "":
		var new = load(new_scene).instantiate() as Node2D
		if deferred:
			world_2d.call_deferred("add_child", new)
		else:
			world_2d.add_child(new)
		current_2d_scene = new
	else:
		current_2d_scene = null

func save_last_level_position(level_to_level: String, position) -> void:
	var save_file = FileAccess.open("user://saved_data/levels_last_positions.csv", FileAccess.WRITE_READ)
	var content = PackedStringArray([level_to_level, str(position.x), str(position.y)])
	while !save_file.eof_reached():
		var read_line = save_file.get_csv_line()
		if read_line.has(level_to_level):
			return
	save_file.store_csv_line(content)
	if !Data.level_last_position:
		Data.level_last_position = {}
	Data.level_last_position[level_to_level] = position

func load_last_level_position():
	if !FileAccess.file_exists("user://saved_data/levels_last_positions.csv"):
		return
	var save_file = FileAccess.open("user://saved_data/levels_last_positions.csv", FileAccess.READ)
	var level_positions = {}
	while !save_file.eof_reached():
		var read_line = save_file.get_csv_line()
		if read_line.size() > 1:
			level_positions[read_line[0]] = Vector2(float(read_line[1]), float(read_line[2]))
	return level_positions

func save_game(level: String) -> void:
	var save_file = FileAccess.open("user://saved_data/savefile.csv", FileAccess.WRITE_READ)
	var current_level = Data.level_files[level]
	var content = PackedStringArray([current_level,str(Data.player_posx),str(Data.player_posy)])
	save_file.store_csv_line(content)
	Data.saved_game = true

func load_game() -> bool:
	var save_file = FileAccess.open("user://saved_data/savefile.csv", FileAccess.READ)
	if !FileAccess.file_exists("user://saved_data/savefile.csv"):
		return false
	var content = save_file.get_csv_line()
	start_transition()
	change_2d_scene(content[0])
	change_gui_scene("")
	Data.level_last_position = load_last_level_position()
	Data.player_posx = float(content[1])
	Data.player_posy = float(content[2])
	Data.loaded_game = true
	end_transition()
	return true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and (current_gui_scene == null or current_gui_scene.name != "UI"):
		change_gui_scene("res://scenes/gui/pause_menu.tscn", false, true)
