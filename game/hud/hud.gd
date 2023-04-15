extends CanvasLayer

@onready var xp_bar = $XPContainer/XP_Bar
@onready var xp_level_label = $XPContainer/Level
@onready var hp_bar = $HPContainer/HP_Bar
@onready var animations = $AnimationPlayer

func _ready():
	pass
		
func set_xp_bar_value(value):
	xp_bar.value = value
	animations.play("xp_flash")

func set_xp_level_label(text):
	xp_level_label.text = text
	
func set_hp_bar_value(value):
	hp_bar.value = value
	animations.play("hp_flash")
