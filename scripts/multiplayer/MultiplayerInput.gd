extends MultiplayerSynchronizer

@onready 
var player: MultiplayerPlayer = $".."

var direction : float = 0

func _ready() -> void:
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	
	direction = get_movement_direction()

func _physics_process(delta: float) -> void:
	direction = get_movement_direction()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		jump.rpc()
	if Input.is_action_just_pressed("dash"):
		dash.rpc()
	if Input.is_action_just_pressed("basic_attack"):
		attack.rpc()
	if Input.is_action_just_pressed("transform"):
		transform.rpc()

func get_movement_direction() -> float:
	if player.dead:
		return 0
	return Input.get_axis("move_left", "move_right")

@rpc("call_local")
func jump() -> void:
	if multiplayer.is_server():
		if player.dead:
			player.do_jump = false
		player.do_jump = true
	

@rpc("call_local")
func dash() -> void:
	if multiplayer.is_server():
		if player.dead:
			player.do_dash = false
		player.do_dash = true

@rpc("call_local")
func attack() -> void:
	if multiplayer.is_server():
		if player.dead:
			player.do_attack = false
		player.do_attack = true

@rpc("call_local")
func transform() -> void:
	if multiplayer.is_server():
		if player.dead:
			player.do_transform = false
		player.do_transform = true
