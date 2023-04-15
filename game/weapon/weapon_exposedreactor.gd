extends Area2D

@onready var damage_radius_collision = $DamageRadiusCollision

@export var damage = 100
@export var damage_interval = 0.2
@export var damage_radius = 200
@export var radiation_color = Color(20, 255, 0, 0.1)

var mobs_in_range = {}
var timer = 0.0

func _ready():
	print("Weapon ready: ",$".")
	damage_radius_collision.shape.radius = damage_radius
	
func _process(delta):
	timer += delta

	if timer >= damage_interval:
		apply_damage_to_enemies()
		timer = 0.0

func apply_damage_to_enemies():
	for mob in mobs_in_range.values():
		if is_instance_valid(mob):
			mob.take_damage(damage)

func _draw():
	draw_circle(Vector2.ZERO, damage_radius, radiation_color)

func _on_body_entered(body):
	if body.is_in_group("mobs"):
		mobs_in_range[body.get_instance_id()] = body

func _on_body_exited(body):
	if body.is_in_group("mobs"):
		mobs_in_range.erase(body.get_instance_id())
