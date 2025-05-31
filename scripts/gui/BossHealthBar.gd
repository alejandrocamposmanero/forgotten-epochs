extends TextureProgressBar
class_name BossHealthBar

@export
var controller: Control

var max_health: int
var health: int

func _ready() -> void:
	max_health = controller.boss.max_health
	health = controller.boss.health
	self.max_value = max_health
	self.value = health

func _process(_delta: float) -> void:
	self.value = controller.boss.health
	if self.value > self.max_value:
		self.value = max_health
	if self.value < 0:
		self.value = 0
