extends Enemy

@onready 
var collision: CollisionShape2D = $collision
@onready 
var collision_attack: CollisionShape2D = $hitboxes/enemy_attack
@onready 
var attack_player: CollisionShape2D = $player_attack/attack_player
@onready 
var animation: AnimatedSprite2D = $animation
@onready 
var cooldown: Timer = $cooldown

var attacking := false
var collisions_flipped := false
var attack_ready := true
var player: Player

func _ready() -> void:
	health = max_health

func _process(delta: float) -> void:
	if dead:
		animation.play("death")
		collision.disabled = true
	if animation.flip_h and !collisions_flipped:
		flip_collisions()
	elif !animation.flip_h and collisions_flipped:
		flip_collisions()

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
		if dead:
			velocity.x = 0
			velocity.y = 0
	else:
		if player:
			
			if !attacking:
				if position.x > player.position.x:
					velocity.x = speed * -1
					animation.flip_h = true
				elif position.x < player.position.x:
					velocity.x = speed
					animation.flip_h = false
				animation.play("run")
			elif attacking and attack_ready:
				velocity.x = 0
				animation.play("attack")
				attack_ready = false
		else:
			velocity.x = 0
			animation.play("idle")
	move_and_slide()

func flip_collisions() -> void:
	collision_attack.position.x *= -1
	attack_player.position.x *= -1
	collisions_flipped = !collisions_flipped
	
func _on_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		body.receive_damage(damage)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body

func _on_player_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		attacking = true
		collision_attack.set_deferred("disabled", false)

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null

func _on_animation_finished() -> void:
	if animation.animation == "death":
		queue_free()
	if animation.animation == "attack":
		collision_attack.disabled = true
		attacking = false
		cooldown.start()

func _on_cooldown_timeout() -> void:
	attack_ready = true
