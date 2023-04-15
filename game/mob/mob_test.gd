extends Area2D

# Adjust these values to fit your needs
@export var speed: float = 100.0
@export var knockback_force: float = 200.0
@export var knockback_duration: float = 0.2
@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

var velocity: Vector2 = Vector2.ZERO
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

func _init():
	pass
	
func _ready():
	start_disabled()
	
func _physics_process(delta):
	if knockback_timer > 0:
		position += knockback * delta
		knockback_timer -= delta
	else:
		velocity = (Global.player.global_position - global_position).normalized() * speed
		position += velocity * delta

func _on_projectile_area_entered(area):
	if area.is_in_group("projectiles"):
		knockback = (global_position - area.global_position).normalized() * knockback_force
		knockback_timer = knockback_duration
		area.queue_free() # Remove the projectile if needed

func start_disabled():
	hide()
	velocity = Vector2.ZERO
	set_physics_process(false)
	monitoring = false
	monitorable = false
	collision_shape.disabled = true
	
