extends CharacterBody3D
# References and properties
var player = null
var state_machine
var health = 72
var is_dead = false
var hit_locations = []  # Track where zombie was hit
const SPEED = 4.0
const ATTACK_RANGE = 2.0
@export var player_path: String = "/root/World/Map/Player"
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var death: AudioStreamPlayer3D = $DeathSound

# Called when the node enters the scene tree.
func _ready():
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")
	
	# Make sure collision is set up properly
	if has_node("HitArea"):
		var hit_area = $HitArea
		# Set proper collision layer and mask
		hit_area.collision_layer = 2  # Layer 2 for zombie hitbox
		hit_area.collision_mask = 4   # Layer 3 for bullets
		
		# Connect the area signals
		hit_area.connect("body_entered", Callable(self, "_on_hit_area_body_entered"))
		hit_area.connect("area_entered", Callable(self, "_on_hit_area_area_entered"))
	
	print("Zombie spawned with health: ", health)
	
	# Connect all body part signals
	for child in get_children():
		if child is Area3D and child.has_signal("body_part_hit"):
			child.connect("body_part_hit", Callable(self, "on_area_3d_body_part_hit"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Skip all movement/AI if dead.
	if is_dead:
		return
	
	velocity = Vector3.ZERO
	
	match state_machine.get_current_node():
		"Run":
			# Update target and compute velocity
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point: Vector3 = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			# Smoothly rotate toward movement direction
			rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10.0)
		"Attack":
			# Face the player during the attack state
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	# Update animation conditions based on distance to the player.
	anim_tree.set("parameters/conditions/Armature_003|mixamo_com|Layer0", target_in_range())
	anim_tree.set("parameters/conditions/run", !target_in_range())
	
	# Apply movement.
	move_and_slide()

# Returns true if the player is within attack range.
func target_in_range() -> bool:
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

# Called when the attack animation's hit frame finishes.
func hit_finished():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE + 1.0:
		var dir: Vector3 = global_position.direction_to(player.global_position)
		player.hit(dir)

# Modify the hit detection function
func _on_hit_area_body_entered(body):
	print("Body entered zombie hitbox: ", body.name)
	print("Body groups: ", body.get_groups())
	
	if body.is_in_group("bullets"):
		print("Bullet hit confirmed!")
		var damage = 1
		if body.has_method("get_damage"):
			damage = body.get_damage()
		elif "damage" in body:
			damage = body.damage
			
		health -= damage
		print("Zombie took damage! Health: ", health)
		
		if health <= 0:
			print("Zombie died!")
			die()
		
		# Make sure to remove the bullet
		body.queue_free()

# Add area detection (in case bullet is an Area3D)
func _on_hit_area_area_entered(area):
	print("Area entered zombie hitbox: ", area.name)
	if area.is_in_group("bullets"):
		print("Bullet (Area) hit confirmed!")
		health -= 1
		print("Zombie took damage! Health: ", health)
		
		if health <= 0:
			print("Zombie died!")
			die()
		
		area.queue_free()

func die() -> void:
	if is_dead:
		return
		
	is_dead = true
	print("=== Zombie Death Summary ===")
	print("Total hits: ", hit_locations.size())
	print("Hit locations: ", hit_locations)
	print("Final health: 0")
	
	# Disable physics and collisions
	set_physics_process(false)
	
	# Disable all collisions
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = true
		elif child is Area3D:
			child.monitoring = false
			child.monitorable = false
	
	# Set death animation
	if anim_tree:
		anim_tree.set("parameters/conditions/die", true)
	
	# Remove the zombie after animation plays
	await get_tree().create_timer(2.0).timeout
	print("Removing zombie instance from game")
	queue_free()

# Debug function to use when troubleshooting
func debug_collision():
	print("Zombie health:", health)
	print("Zombie position:", global_position)
	print("Is dead:", is_dead)
	print("Distance to player:", global_position.distance_to(player.global_position))
	
	# You can call this function from the console or add a key to trigger it
	# Input.is_action_just_pressed("debug_key")

# Update the damage handling function
func on_area_3d_body_part_hit(damage: int) -> void:
	if is_dead:
		return
		
	health -= damage
	
	# Log the hit and remaining health
	print("Zombie took ", damage, " damage!")
	print("Remaining health: ", health)
	
	if health <= 0:
		print("Fatal damage! Zombie eliminated.")
		die()
	else:
		# Optional: Add hit reaction animation here
		print("Zombie staggered from hit!")

# Add this function to track bullet hits
func _on_bullet_hit(body_part_name: String, damage: int):
	hit_locations.append(body_part_name)
	print("Hit registered on: ", body_part_name)
	print("Damage dealt: ", damage)

# New damage handling function
func take_damage(damage: int, hit_location: String) -> void:
	if is_dead:
		return
		
	health -= damage
	hit_locations.append(hit_location)
	
	print("=== Damage Report ===")
	print("Hit location: ", hit_location)
	print("Damage dealt: ", damage)
	print("Remaining health: ", health)
	
	if health <= 0:
		death.play()
		print("Fatal damage! Zombie eliminated.")
		die()
	else:
		print("Zombie staggered from hit!")
