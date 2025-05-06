extends Enemy

const SPEED = 300.0

@onready var animation: AnimatedSprite2D = $animation

func _process(delta: float) -> void:
	if animation.animation == "walk":
		animation.position.y -= 12
	else:
		animation.position = Vector2(0,0)
	
	
	
