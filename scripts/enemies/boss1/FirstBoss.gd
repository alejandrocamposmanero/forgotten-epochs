extends Enemy
@onready 
var animation: AnimatedSprite2D = $animation
@onready 
var collision: CollisionShape2D = $collision
@onready 
var collision_attack1_pt1_r: CollisionPolygon2D = $attacks_collision/attack1_pt1_right
@onready 
var collision_attack1_pt2_r: CollisionPolygon2D = $attacks_collision/attack1_pt2_right
@onready 
var collision_attack1_pt1_l: CollisionPolygon2D = $attacks_collision/attack1_pt1_left
@onready 
var collision_attack1_pt2_l: CollisionPolygon2D = $attacks_collision/attack1_pt2_left
@onready 
var collision_attack2_r: CollisionPolygon2D = $attacks_collision/attack2_right
@onready
var collision_attack2_l: CollisionPolygon2D = $attacks_collision/attack2_left
@onready 
var detect_attack_2: CollisionShape2D = $second_attack_detect/attack2
@onready 
var cooldown: Timer = $cooldown


@export
var player: Player

var collision_flipped := false
var attacking := false
var first_attack := false
var second_attack := false
var attack_ready := false

func _ready() -> void:
	attack_ready = true
	dead = false
	health = max_health
	animation.play("idle")

func _process(delta: float) -> void:
	if dead:
		collision.disabled = true
		animation.play("death")
	if animation.flip_h and !collision_flipped:
		flip_collision()
	elif !animation.flip_h and collision_flipped:
		flip_collision()
	

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
		if dead:
			velocity.y = 0
	elif !dead:
		if !attacking:
			if position.x == player.position.x:
				velocity.x = 0
				animation.play("idle")
			elif position.x > player.position.x:
				velocity.x = speed * -1
				animation.flip_h = true
				animation.play("run")
			elif position.x < player.position.x:
				velocity.x = speed
				animation.flip_h = false
				animation.play("run")
		elif first_attack and attack_ready:
			velocity.x = 0
			animation.play("attack1")
		elif second_attack and attack_ready:
			velocity.x = 0
			animation.play("attack2")
	move_and_slide()

func flip_collision() -> void:
	detect_attack_2.position.x *= -1
	collision_flipped = !collision_flipped

func _on_animation_finished() -> void:
	if animation.animation == "death":
		queue_free()
	if animation.animation == "attack1" or animation.animation == "attack2":
		collision_attack2_r.disabled = true
		collision_attack2_l.disabled = true
		attacking = false
		attack_ready = false
		first_attack = false
		second_attack = false
		cooldown.start()

func _on_first_attack_detect_body_entered(body: Node2D) -> void:
	if body is Player:
		attacking = true
		first_attack = true

func _on_second_attack_detect_body_entered(body: Node2D) -> void:
	if body is Player:
		attacking = true
		if animation.flip_h:
			collision_attack2_r.disabled = false
		else:
			collision_attack2_l.disabled = false
		second_attack = true

func _on_cooldown_timeout() -> void:
	attack_ready = true

func _on_attacks_collision_body_entered(body: Node2D) -> void:
	if body is Player:
		body.receive_damage(damage)

func _on_animation_frame_changed() -> void:
	if animation.animation == "attack1":
		if animation.flip_h:
			if animation.frame > 0 and animation.frame < 5:
				collision_attack1_pt1_r.disabled = false
			else:
				collision_attack1_pt1_r.disabled = true
			if animation.frame > 5 and animation.frame < 9:
				collision_attack1_pt2_r.disabled = false
			else:
				collision_attack1_pt2_r.disabled = true
		else:
			if animation.frame > 0 and animation.frame < 5:
				collision_attack1_pt1_l.disabled = false
			else:
				collision_attack1_pt1_l.disabled = true
			if animation.frame > 5 and animation.frame < 9:
				collision_attack1_pt2_l.disabled = false
			else:
				collision_attack1_pt2_l.disabled = true
