extends Area3D

var damage := 2  # Default damage for limbs

signal body_part_hit(dam)


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set damage based on the node name
	var node_name = name.to_lower()
	if "spine" in node_name or "head" in node_name:
		damage = 5  # More damage for critical hits
	elif "leg" in node_name or "arm" in node_name:
		damage = 2  # Default damage for limbs
	
	print("Body part initialized: ", name, " with damage: ", damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func hit():
	print("Hit on: ", name, " for ", damage, " damage")
	emit_signal("body_part_hit", damage)
