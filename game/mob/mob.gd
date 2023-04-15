extends CharacterBody2D

@onready var item = preload("res://game/item/item.tscn")
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var health_label = $Health

var target_position = Vector2.ZERO
var speed = 100
var health = 100
var damage = 5

var mob_respawn_distance_range = 5000

var viewport_rect = Rect2()

func _ready():
	health_label.text = str(health)
	viewport_rect = get_viewport_rect()

func _physics_process(delta: float) -> void:
	animated_sprite.flip_h = global_position.x > Global.player.global_position.x
	
	var viewport_size = viewport_rect.size
	var player_position = Global.player.global_position
	var player_direction = (player_position - global_position).normalized()
	
	if not viewport_rect.has_point(global_position) and global_position.distance_to(player_position) > viewport_size.length() * 1.2:
		move_to_new_position(player_position, player_direction, viewport_size)

	update_target_position()
	move_towards_target(delta)

func update_target_position() -> void:
	target_position = Global.player.global_position

func move_towards_target(delta: float) -> void:
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
func take_damage(damage_amount):
	animation_player.play("flash")
	health -= damage_amount
	if health <= 0:
		self.get_node("CollisionShape2D").disabled = true
		self.velocity = Vector2.ZERO
		self.set_physics_process(false)
		animated_sprite.animation = "death"
		animation_player.play("death")
		drop_item()
	else:
		health_label.text = str(health)
		animation_player.play("flash")

func drop_item():
	var xp = item.instantiate()
	xp.global_position = global_position
	Global.items.add_child(xp)

func move_to_new_position(player_position, player_direction, viewport_size):
	var random_angle = deg_to_rad(randf_range(-mob_respawn_distance_range, mob_respawn_distance_range))
	var new_position = player_position + (player_direction.rotated(random_angle) * viewport_size.length() * 1.2)
	
	# Check if new_position is inside the viewport
	var viewport_rect = get_viewport_rect()
	while viewport_rect.has_point(new_position):
		# Find a new position outside the viewport
		random_angle = deg_to_rad(randf_range(-mob_respawn_distance_range, mob_respawn_distance_range))
		new_position = player_position + (player_direction.rotated(random_angle) * viewport_size.length() * 1.2)
	
	global_position = new_position

func _on_animated_sprite_2d_animation_finished():
	queue_free()

