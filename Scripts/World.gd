extends Node3D

@onready var hit_rect = $UI/HitRect
@onready var spawns = $Map/Spawns
@onready var navigation_region = $Map/NavigationRegion3D

var zombie = load("res://Scenes/Zombie.tscn")
var instance


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_player_player_hit():
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false


func _get_random_child(parent_node):
	if parent_node.get_child_count() == 0:
		return null  # Prevents errors if there are no children
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)

func _on_zombie_spawn_timer_timeout():
	var spawn_point = _get_random_child(spawns)
	if spawn_point:  # Ensure spawn_point is valid before using it
		instance = zombie.instantiate()
		instance.position = spawn_point.global_position
		navigation_region.add_child(instance)
