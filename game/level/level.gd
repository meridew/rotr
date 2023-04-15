extends Node2D

@onready var mob = preload("res://game/mob/mob.tscn")
@onready var mobs = [mob]
@onready var max_mobs = 2000
@onready var mob_spawn_timer = $ParallaxBackground/MobSpawner

func _on_mob_spawner_timeout():
	var current_mobs = Global.mobs.get_child_count()

	if(current_mobs < max_mobs):
		var mob_type = mobs[randi() % mobs.size()]
		var this_mob = mob_type.instantiate()
		var viewport_size = get_viewport_rect().size
		var angle = randf_range(0, 2 * PI)
		var spawn_radius = max(viewport_size.x, viewport_size.y) * 0.5 + 100
		var spawn_position = Global.player.global_position + Vector2(cos(angle), sin(angle)) * spawn_radius
		this_mob.global_position = spawn_position
		Global.mobs.add_child(this_mob)
