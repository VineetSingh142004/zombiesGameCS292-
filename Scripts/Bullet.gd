extends Node3D

const SPEED = 40.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("bullets")
	# Make sure the RayCast3D is enabled
	ray.enabled = true
	# Set proper collision mask for the ray (adjust the value based on your collision layers)
	ray.collision_mask = 2  # Assuming layer 2 is for zombies

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	
	if ray.is_colliding():
		var collider = ray.get_collider()
		print("Bullet hit: ", collider.name)
		
		# Get damage based on hit location
		var damage = calculate_damage(collider.name)
		
		# Find the parent zombie and apply damage
		var parent = collider.get_parent()
		while parent != null:
			if parent.has_method("take_damage"):
				print("Applying damage to zombie: ", damage)
				parent.take_damage(damage, collider.name)
				break
			parent = parent.get_parent()
		
		mesh.visible = false
		particles.emitting = true
		ray.enabled = false
		
		await get_tree().create_timer(1.0).timeout
		queue_free()

func calculate_damage(bone_name: String) -> int:
	bone_name = bone_name.to_lower()
	if "spine" in bone_name or "head" in bone_name:
		return 5
	elif "leg" in bone_name or "arm" in bone_name:
		return 2
	return 2  # Default damage

func _on_timer_timeout():
	queue_free()
