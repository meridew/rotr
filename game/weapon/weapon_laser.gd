extends Node2D

@export var rotation_speed: float = 45.0
@export var fire_rate: float = 1.0
export(float, 0.1, 5.0, 0.1) 
var laser_duration: float = 0.5
@export var laser_length: float = 300.0
@export var laser_width: float = 4.0

@onready var laser: Line2D = $Laser
@onready var timer: Timer = Timer.new()

func _ready():
	add_child(timer)
	timer.set_wait_time(1.0 / fire_rate)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()
	laser.width = 0.0

func _process(delta: float):
	rotation += deg2rad(rotation_speed * delta)

func _on_timer_timeout():
	laser.width = laser_width
	laser.points = [Vector2.ZERO, Vector2(laser_length, 0).rotated(rotation)]
	yield(get_tree().create_timer(laser_duration), "timeout")
	laser.width = 0.0
