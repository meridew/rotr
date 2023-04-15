extends Node

var armoury

func _ready():
	armoury = WeaponSystem.Armoury.new()
	
	var available_items = armoury.get_available_weapons_and_upgrades(3)
	var item_to_select = available_items[0]
	var items_to_return = available_items.slice(1,3)

	print("Selecting item:", item_to_select)
	armoury.select_item(item_to_select)
	
	print("Returning items:", items_to_return)
	armoury.return_items(items_to_return)
	
	print("\n----- show_not_taken_weapons -----")
	armoury.show_not_taken_weapons()
	
	print("\n----- show_taken_weapons -----")
	armoury.show_taken_weapons()
	
	print("")
