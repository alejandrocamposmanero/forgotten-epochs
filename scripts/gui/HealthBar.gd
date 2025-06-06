extends TextureProgressBar
class_name HealthBar

var total_health: int

func _ready() -> void:
	total_health = Data.total_health
	self.max_value = total_health
	self.value = Data.player_health

func _process(_delta: float) -> void:
	self.value = Data.player_health
	if self.value > total_health:
		self.value = total_health
	if self.value < 0:
		self.value = 0
