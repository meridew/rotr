extends Node2D

# Export variables for editor customization
@onready var mob_node = $"../Mobs"
@onready var pool_mob = preload("res://game/mob/pool_mob.tscn")
@export var pool_size = 1000

# Internal variables
var _mob_pool: Array = []
var _active_mobs: Array = []

func _on_game_ready():
	_initialize_pool()

func _initialize_pool():
	for _i in range(pool_size):
		var mob_instance = pool_mob.instantiate()
		mob_instance.position = get_spawn_location()
		var connection_result = mob_instance.connect("death", Callable(self, "_on_mob_death"))
		mob_instance.call("disable")
		_mob_pool.append(mob_instance)
		print("Added mob to pool. Pool size:", _mob_pool.size())
		mob_node.add_child(mob_instance)


func activate_mob():
	if _mob_pool.size() > 0:
		var mob = _mob_pool.pop_front()
		_active_mobs.append(mob)
		mob.position = get_spawn_location()
		mob.call("enable")  # Add this line to enable the mob
		print("Activating mob. Pool size:", _mob_pool.size(), "Active mobs:", _active_mobs.size())
		return mob
	return null

func _on_mob_death(mob):
	_active_mobs.erase(mob)
	_mob_pool.append(mob)
	mob.call("disable")
	print("Mob disabled. Pool size:", _mob_pool.size(), "Active mobs:", _active_mobs.size())

func _on_spawn_timer_timeout():
	activate_mob()

func get_spawn_location():
	var angle = randf_range(0, 2 * PI)
	var spawn_radius = max(Global.viewport_size.x, Global.viewport_size.y) * 0.5 + 100
	var spawn_position = Global.player.global_position + Vector2(cos(angle), sin(angle)) * spawn_radius
	return spawn_position
