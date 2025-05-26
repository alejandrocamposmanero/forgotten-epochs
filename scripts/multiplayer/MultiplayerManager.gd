extends Node

const SERVER_PORT := 8080
const SERVER_IP := "127.0.0.1"

var multiplayer_scene = preload("res://scenes/multiplayer/multiplayer_player.tscn")
var players_spawn
var server
var client

func become_host() -> void:
	players_spawn = get_tree().get_current_scene().get_node("world2d").get_node("multiplayer_level").get_node("players")
	server = ENetMultiplayerPeer.new()
	server.create_server(SERVER_PORT, 2)
	
	multiplayer.multiplayer_peer = server
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_del_player)
	
	_add_player_to_game(1)

func join_host() -> void:
	client = ENetMultiplayerPeer.new()
	client.create_client(SERVER_IP, SERVER_PORT)
	
	multiplayer.multiplayer_peer = client

func disconnect_host() -> void:
	if client != null:
		client.close()

func _add_player_to_game(id: int) -> void:
	var player_to_add = multiplayer_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	players_spawn.add_child(player_to_add, true)

func _del_player(id: int) -> void:
	if !players_spawn.has_node(str(id)):
		return
	players_spawn.get_node(str(id)).queue_free()
	
