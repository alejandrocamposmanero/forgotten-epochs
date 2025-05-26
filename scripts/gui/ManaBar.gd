extends TextureProgressBar
class_name ManaBar

var total_mana: int

func _ready() -> void:
	total_mana = 100
	self.value = Data.player_mana

func _process(_delta: float) -> void:
	self.value = Data.player_mana
	if self.value > total_mana:
		self.value = total_mana
	if self.value < 0:
		self.value = 0
