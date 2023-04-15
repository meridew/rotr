extends CanvasLayer

@onready var tree = $MarginContainer/HBoxContainer/Tree

func _on_game_ready():
		
	print("Debug HUD loaded...")
	
	populate_tree()

func populate_tree() -> void:
	tree.clear()
	var root = tree.create_item()

	var taken_weapons = tree.create_item(root)
	taken_weapons.set_text(0, "Taken Weapons")
	for weapon in Global.armoury.weapons:
		if weapon.taken:
			var weapon_item = tree.create_item(taken_weapons)
			weapon_item.set_text(0, weapon.name)
			var stats_item = tree.create_item(weapon_item)
			stats_item.set_text(0, "Stats")
			for stat_key in weapon.stats.keys():
				var stat_item = tree.create_item(stats_item)
				stat_item.set_text(0, stat_key + ": " + str(weapon.stats[stat_key]))
			var upgrades_item = tree.create_item(weapon_item)
			upgrades_item.set_text(0, "Upgrades")
			for upgrade_name in weapon.upgrades.keys():
				var upgrade_item = tree.create_item(upgrades_item)
				var taken = weapon.upgrades[upgrade_name].taken
				var max = weapon.upgrades[upgrade_name].max
				upgrade_item.set_text(0, upgrade_name + ": " + str(taken) + "/" + str(max))

	var not_taken_weapons = tree.create_item(root)
	not_taken_weapons.set_text(0, "Not Taken Weapons")
	for weapon in Global.armoury.weapons:
		if not weapon.taken:
			var weapon_item = tree.create_item(not_taken_weapons)
			weapon_item.set_text(0, weapon.name)
			var stats_item = tree.create_item(weapon_item)
			stats_item.set_text(0, "Stats")
			for stat_key in weapon.stats.keys():
				var stat_item = tree.create_item(stats_item)
				stat_item.set_text(0, stat_key + ": " + str(weapon.stats[stat_key]))

func _on_menu_level_up_update_debug_hud():
	populate_tree()
