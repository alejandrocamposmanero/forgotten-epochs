extends Node

var total_health: int = 100
var total_mana: int = 100
var transformed: bool = false
var player_health: int
var player_mana: float
var player_posx: float
var player_posy: float

var can_save: bool = false
var loaded_game: bool = false
var level_changed: bool = false
var saved_game: bool = false

var level_last_position = {}
var level_files = {}

func _ready() -> void:
	player_health = total_health
	player_mana = total_mana
