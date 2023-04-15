extends Node

const WeaponSystem = preload("res://class/weapon_system.gd")

var main_menu: Node2D
var game: Node2D
var level: Node2D
var player: Node2D
var mob_spawner: Node2D
var spawn_timer: Timer
var mobs: Node2D
var projectiles: Node2D
var items: Node2D
var hud: CanvasLayer
var menu_levelup: CanvasLayer
var menu_main: CanvasLayer
var menu_pause: CanvasLayer
var debug_hud: CanvasLayer
var debug_info: CanvasLayer
var game_over: CanvasLayer
var player_damage_timer: Timer
var viewport_size: Vector2
var weapon_system: WeaponSystem
var armoury
