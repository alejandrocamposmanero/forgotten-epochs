extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/AnimatedSprite2D.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer.visible = $".".visible
	if Input.is_action_just_pressed("interact") and Data.can_save:
		$CanvasLayer/AnimatedSprite2D.visible = true
