extends StaticBody3D

@onready var rotation_center = $"../RotationCenter"

var rotation_amount: int = 0

func set_rotation_amount(amount) -> void:
	# Parse string to int
	rotation_amount = int(amount)
	rotation_center.rotation.y = deg_to_rad(rotation_amount)
