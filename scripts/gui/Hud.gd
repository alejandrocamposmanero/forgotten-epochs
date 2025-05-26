extends Control

@onready 
var saving: AnimatedSprite2D = $CanvasLayer/AnimatedSprite2D
@onready 
var saving_timer: Timer = $saving

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/AnimatedSprite2D.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$CanvasLayer.visible = $".".visible
	if Input.is_action_just_pressed("interact") and Data.can_save:
		saving.visible = true
		saving_timer.start()


func _on_saving_timeout() -> void:
	saving.visible = false
