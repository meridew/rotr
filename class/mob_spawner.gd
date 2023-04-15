extends Node

@onready var mob_scene = preload("res://game/mob/mob_test.tscn")

var _max_mobs = 1000
var _inactive_mobs = []
var _active_mobs = []

func _ready():
	for i in range(_max_mobs):
		var mob = mob_scene.instantiate()
		_inactive_mobs += mob



