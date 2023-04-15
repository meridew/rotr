extends Node2D

@onready var game = preload("res://game/game.tscn")

func _ready():
	Global.menu_main = $Menu_Main

func _on_start_pressed():
	$Menu_Main.hide()
	add_child(game.instantiate())

func _on_quit_pressed():
	get_tree().quit()
