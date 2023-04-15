extends Node2D

@onready var player = $Player
@onready var debug_hud = $Deug_Hud

func _ready():
	
	Global.game = $"."
	Global.level = $Level
	Global.player = $Player
	Global.player_damage_timer = $Player_Damage_Timer
	Global.mobs = $Mobs
	Global.projectiles = $Projectiles
	Global.items = $Items
	Global.hud = $HUD
	Global.menu_levelup = $Menu_LevelUp
	Global.menu_pause = $Menu_Pause
	Global.game_over = $Game_Over
	Global.armoury = WeaponSystem.Armoury.new()
	Global.viewport_size = get_viewport_rect().size

func _input(event):
	if event.is_action_pressed("escape"):
		get_tree().paused = true
		Global.menu_pause.show()
	
	if event.is_action_pressed("debug"):
		debug_hud.visible = !debug_hud.visible

func _process(_delta):
	pass
		
func update_hud(type):
	match (type):
		"xp":
			var xp_percentage = float(player.xp) / player.max_xp * 100
			Global.hud.set_xp_bar_value(xp_percentage)
			Global.hud.set_xp_level_label("Level " + str(player.level))
		"hp":
			var hp_percentage = float(player.hp) / player.max_hp * 100
			Global.hud.set_hp_bar_value(hp_percentage)

func _on_return_pressed():
	Global.menu_main.show()
	get_tree().paused = false
	self.queue_free()

func _on_resume_pressed():
	get_tree().paused = false
	Global.menu_pause.hide()

func _on_quit_pressed():
	Global.menu_main.show()
	get_tree().paused = false
	self.queue_free()
	
func _on_player_player_levelup():
	update_hud("xp") # Replace with function body.

func _on_player_update_hud(type):
	update_hud(type) # Replace with function body.
