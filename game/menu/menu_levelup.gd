extends CanvasLayer

@onready var menu_levelup_option0 = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button1")
@onready var menu_levelup_option1 = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button2")
@onready var menu_levelup_option2 = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Button3")

var buttons = [menu_levelup_option0, menu_levelup_option1, menu_levelup_option2]
var all_options
var selected_option

signal update_debug_hud

func _on_game_ready():
	all_options = Global.armoury.get_available_weapons_and_upgrades(3)

func set_menu_levelup_buttons():
	
	all_options = Global.armoury.get_available_weapons_and_upgrades(3)
	
	for option_key in range(all_options.size()):
		var option = all_options[option_key]
		if option_key == 0:
			menu_levelup_option0.text = option.type + "\n" + option.name
			if("upgrade" in option):
				menu_levelup_option0.text += "\n" + option.upgrade + " + " + str(option.increase * 100) + "%"
		elif option_key == 1:
			menu_levelup_option1.text = option.type + "\n" + option.name
			if("upgrade" in option):
				menu_levelup_option0.text += "\n" + option.upgrade + " + " + str(option.increase * 100) + "%"
		elif option_key == 2:
			menu_levelup_option2.text = option.type + "\n" + option.name
			if("upgrade" in option):
				menu_levelup_option0.text += "\n" + option.upgrade + " + " + str(option.increase * 100) + "%"

func _on_player_player_levelup():
	set_menu_levelup_buttons()

func _on_button_1_pressed():
	update_armoury(0)

func _on_button_2_pressed():
	update_armoury(1)

func _on_button_3_pressed():
	update_armoury(2)

func update_armoury(selected_option_index):

	var selected_option = all_options[selected_option_index]
	var return_options = []

	for i in range(len(all_options)):
		if i != selected_option_index:
			return_options.append(all_options[i])

	Global.armoury.select_item(selected_option)
	Global.armoury.return_items(return_options)
	emit_signal("update_debug_hud")
	Global.menu_levelup.hide()
	get_tree().paused = false
