extends Area2D

var attracted_items = []

func _ready():
	print("Weapon ready: ", $".")

func _physics_process(delta: float) -> void:
	for item in attracted_items:
		item.position = item.calculate_new_position(Global.player.position, delta)

func _on_area_entered(area):
	if area.is_in_group("xp"):
		#print("area: item detected")
		attracted_items.append(area)

func _on_area_exited(area):
	if area.is_in_group("xp"):
		#print("area: item exited")
		attracted_items.erase(area)
