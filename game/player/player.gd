extends CharacterBody2D

@onready var damage_timer = $DamageTimer
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D

var speed = 500
var max_hp = 1000000
var max_xp = 100
var hp = 1000000
var xp = 0
var level = 0

signal player_levelup
signal update_hud(type)

var mobs_in_range = []

# player.gd
func _physics_process(delta: float):
	get_input()
	move_and_slide()
	handle_mobs_in_range()

func handle_mobs_in_range():
	if mobs_in_range:
		var mobs_total_damage = 0
		for mob in mobs_in_range:
			if mob._is_alive: # Check if the mob is alive before adding its damage
				mobs_total_damage += mob.damage
		if mobs_total_damage > 0:
			take_damage(mobs_total_damage)
			animation_player.play("flash")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction.x != 0:
		animated_sprite.set_flip_h(input_direction.x < 0)
	
func level_up():
	max_xp = max_xp * 1.2
	level += 1
	xp = 0
	get_tree().paused = true
	emit_signal("player_levelup")
	Global.menu_levelup.visible = true

func add_xp(area):
	area.queue_free()
	xp += area.value 
	if xp >= max_xp:
		level_up()
	emit_signal("update_hud","xp")

func take_damage(amount):
	if(damage_timer.is_stopped()):
		hp -= amount
		if hp <= 0:
			player_died()
		emit_signal("update_hud","hp")
		damage_timer.start()

func player_died():
	get_tree().paused = true
	Global.game_over.visible = true

func _on_damage_area_body_entered(body):
	if(body.is_in_group('mobs')):
		mobs_in_range.append(body)

func _on_damage_area_body_exited(body):
	if(body.is_in_group('mobs')):
		mobs_in_range.erase(body)

func _on_pickup_area_area_entered(area):
	add_xp(area)
