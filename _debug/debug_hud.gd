extends CanvasLayer

@onready var armoury_weapons_grid = $Control/MarginContainer/ColorRect/HBoxContainer/ArmouryWeapons
@onready var player_weapons_grid = $Control/MarginContainer/ColorRect/HBoxContainer/PlayerWeapons

var is_visible = false

func _on_game_ready():
	populate_grids()

func populate_grids() -> void:
	populate_grid(player_weapons_grid, true)
	populate_grid(armoury_weapons_grid, false)

func populate_grid(grid: GridContainer, taken: bool) -> void:
	# Clear previous items in the grid
	for child in grid.get_children():
		child.queue_free()

	# Add header row
	var headers = ["Weapon", "Stats", "Upgrades", "Taken", "Upgrade Count"]
	for header in headers:
		var header_label = Label.new()
		header_label.text = header
		# header_label.add_font_override("font", load("res://your_custom_font.tres"))
		grid.add_child(header_label)

	for weapon in Global.armoury.weapons:
		if weapon.taken == taken:
			var weapon_label = Label.new()
			weapon_label.text = weapon.name
			grid.add_child(weapon_label)

			var stats_text = ""
			for stat_key in weapon.stats.keys():
				stats_text += stat_key + ": " + str(weapon.stats[stat_key]) + "\n"
			var stats_label = Label.new()
			stats_label.text = stats_text
			grid.add_child(stats_label)

			var upgrades_text = ""
			var upgrade_count = 0
			for upgrade_name in weapon.upgrades.keys():
				var taken_upgrade = weapon.upgrades[upgrade_name].taken
				var max = weapon.upgrades[upgrade_name].max
				upgrades_text += upgrade_name + ": " + str(taken_upgrade) + "/" + str(max) + "\n"
				if taken_upgrade:
					upgrade_count += 1
			var upgrades_label = Label.new()
			upgrades_label.text = upgrades_text
			grid.add_child(upgrades_label)

			var taken_label = Label.new()
			taken_label.text = str(weapon.taken)
			grid.add_child(taken_label)

			var upgrade_count_label = Label.new()
			upgrade_count_label.text = str(upgrade_count)
			grid.add_child(upgrade_count_label)

func _on_menu_level_up_update_debug_hud():
	populate_grids()
