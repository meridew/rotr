class_name WeaponSystem

extends Node

class Upgrade:
	var name: String
	var max: int
	var taken: int
	var increase: float

	func _init(name: String, max: int, increase: float):
		self.name = name
		self.max = max
		self.taken = 0
		self.increase = increase
		
class Weapon:
	var name: String
	var taken: bool
	var stats: Dictionary
	var upgrades: Dictionary

	func _init(name: String, taken: bool, stats: Dictionary, upgrades: Dictionary):
		self.name = name
		self.taken = taken
		self.stats = stats
		self.upgrades = upgrades

class Armoury:
		
	var weapons: Array

	func _init():
		weapons = []
		create_weapons()

	func create_weapons():
		var weapon_data = [
			{
				"name": "Weapon_GaussCanon",
				"stats": {
					"Projectile_Size": 25,
					"Projectile_Speed": 500,
					"Projectile_Quantity": 1,
					"Mob_Passthrough": 0,
					"Projectile_Damage": 100
				},
				"upgrades": [
					{"name": "Projectile_Size", "max": 3, "increase": 0.1},
					{"name": "Projectile_Speed", "max": 3, "increase": 0.1},
					{"name": "Projectile_Quantity", "max": 3, "increase": 0.1},
					{"name": "Mob_Passthrough", "max": 1, "increase": 1},
					{"name": "Projectile_Damage", "max": 5, "increase": 0.1}
				]
			},
			{
				"name": "Weapon_LaserRifle",
				"stats": {
					"Beam_Width": 10,
					"Beam_Length": 1000,
					"Fire_Rate": 1,
					"Heat_Reduction": 0,
					"Beam_Damage": 50
				},
				"upgrades": [
					{"name": "Beam_Width", "max": 3, "increase": 0.1},
					{"name": "Beam_Length", "max": 3, "increase": 0.1},
					{"name": "Fire_Rate", "max": 3, "increase": 0.1},
					{"name": "Heat_Reduction", "max": 2, "increase": 0.5},
					{"name": "Beam_Damage", "max": 5, "increase": 0.1}
				]
			},
			{
				"name": "Weapon_ElectroMagent",
				"stats": {
					"Projectile_Size": 25,
					"Projectile_Speed": 500,
					"Projectile_Quantity": 1,
					"Mob_Passthrough": 0,
					"Projectile_Damage": 100
				},
				"upgrades": [
					{"name": "Projectile_Size", "max": 3, "increase": 0.1},
					{"name": "Projectile_Speed", "max": 3, "increase": 0.1},
					{"name": "Projectile_Quantity", "max": 3, "increase": 0.1},
					{"name": "Mob_Passthrough", "max": 1, "increase": 1},
					{"name": "Projectile_Damage", "max": 5, "increase": 0.1}
				]
			},
			{
				"name": "Weapon_DroneBombingRun",
				"stats": {
					"Projectile_Size": 25,
					"Projectile_Speed": 500,
					"Projectile_Quantity": 1,
					"Mob_Passthrough": 0,
					"Projectile_Damage": 100
				},
				"upgrades": [
					{"name": "Projectile_Size", "max": 3, "increase": 0.1},
					{"name": "Projectile_Speed", "max": 3, "increase": 0.1},
					{"name": "Projectile_Quantity", "max": 3, "increase": 0.1},
					{"name": "Mob_Passthrough", "max": 1, "increase": 1},
					{"name": "Projectile_Damage", "max": 5, "increase": 0.1}
				]
			},
			{
				"name": "Weapon_Nuke",
				"stats": {
					"Beam_Width": 10,
					"Beam_Length": 1000,
					"Fire_Rate": 1,
					"Heat_Reduction": 0,
					"Beam_Damage": 50
				},
				"upgrades": [
					{"name": "Beam_Width", "max": 3, "increase": 0.1},
					{"name": "Beam_Length", "max": 3, "increase": 0.1},
					{"name": "Fire_Rate", "max": 3, "increase": 0.1},
					{"name": "Heat_Reduction", "max": 2, "increase": 0.5},
					{"name": "Beam_Damage", "max": 5, "increase": 0.1}
				]
			},
			{
				"name": "Weapon_DefenseTurret",
				"stats": {
					"Projectile_Size": 25,
					"Projectile_Speed": 500,
					"Projectile_Quantity": 1,
					"Mob_Passthrough": 0,
					"Projectile_Damage": 100
				},
				"upgrades": [
					{"name": "Projectile_Size", "max": 3, "increase": 0.1},
					{"name": "Projectile_Speed", "max": 3, "increase": 0.1},
					{"name": "Projectile_Quantity", "max": 3, "increase": 0.1},
					{"name": "Mob_Passthrough", "max": 1, "increase": 1},
					{"name": "Projectile_Damage", "max": 5, "increase": 0.1}
				]
			}
		]

		for weapon_info in weapon_data:
			var weapon_stats = weapon_info["stats"]
			var weapon_upgrades = {}
			for upgrade_info in weapon_info["upgrades"]:
				var upgrade = Upgrade.new(
					upgrade_info["name"],
					upgrade_info["max"],
					upgrade_info["increase"]
				)
				weapon_upgrades[upgrade.name] = upgrade
			weapons.append(Weapon.new(weapon_info["name"], false, weapon_stats, weapon_upgrades))

	func get_available_weapons_and_upgrades(amount: int) -> Array:
		var available_items: Array = []
		for weapon in weapons:
			if not weapon.taken:
				available_items.append({"type": "weapon", "name": weapon.name})
			else:
				for upgrade_name in weapon.upgrades.keys():
					if weapon.upgrades[upgrade_name].taken < weapon.upgrades[upgrade_name].max:
						available_items.append({
							"name": weapon.name,
							"type": "upgrade",
							"weapon": weapon.name,
							"upgrade": upgrade_name,
							"increase": weapon.upgrades[upgrade_name].increase
						})

		if available_items.size() <= amount:
			return available_items

		var random_items: Array = []
		for _i in range(amount):
			var random_index = randi() % available_items.size()
			random_items.append(available_items[random_index])
			available_items.erase(random_index)

		return random_items

	func select_item(item: Dictionary) -> bool:
		for weapon in weapons:
			if item["type"] == "weapon" and weapon.name == item["name"]:
				weapon.taken = true
				return true
			elif item["type"] == "upgrade" and weapon.name == item["weapon"]:
				var upgrade = weapon.upgrades[item["upgrade"]]
				if upgrade.taken < upgrade.max:
					upgrade.taken += 1
					weapon.stats[item["upgrade"]] *= 1 + upgrade.increase
					return true
		return false

	func return_items(items: Array) -> bool:
		for item in items:
			if item["type"] == "weapon":
				for weapon in weapons:
					if weapon.name == item["name"]:
						weapon.taken = false
			elif item["type"] == "upgrade":
				for weapon in weapons:
					if weapon.name == item["weapon"]:
						var upgrade = weapon.upgrades[item["upgrade"]]
						weapon.stats[item["upgrade"]] /= pow(1 + upgrade.increase, upgrade.taken)
						upgrade.taken = 0
		return true
		
	func show_taken_weapons():
		var weapons_taken = "---------- PLAYER WEAPONS ----------" + "\n"
		for weapon in weapons:
			if weapon.taken:
				weapons_taken += str(weapon.name) + "\n"
				weapons_taken += "    Stats:" + "\n"
				weapons_taken += "        " + str(weapon.stats) + "\n"
				weapons_taken += "    Upgrades:" + "\n"
				weapons_taken += "        " + str(weapon.upgrades) + "\n"
		return weapons_taken

	func show_not_taken_weapons():
		var weapons_not_taken = "---------- ARMOURY WEAPONS ----------" + "\n"
		for weapon in weapons:
			if not weapon.taken:
				weapons_not_taken += str(weapon.name) + "\n"
				weapons_not_taken += "    Stats:" + "\n" 
				weapons_not_taken += "        " + str(weapon.stats) + "\n"
		return weapons_not_taken

	func show_all_upgrades() -> void:
		print("All Upgrades:")
		for weapon in weapons:
			print(" -", weapon.name)
			for upgrade_name in weapon.upgrades.keys():
				print("   -", upgrade_name, ":", weapon.upgrades[upgrade_name].taken, "/", weapon.upgrades[upgrade_name].max, "(", weapon.upgrades[upgrade_name].increase, "increase)")
				

