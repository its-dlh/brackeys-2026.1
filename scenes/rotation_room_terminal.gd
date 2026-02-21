extends StaticBody3D

@onready var rotation_center = $"../RotationCenter"

@onready var rotation_amount: float = PI / 4 + 2 * PI

const ROTATION_AMOUNT_PER_SECOND = PI / 2

func _ready() -> void:
	rotation_center.rotation.y = rotation_amount

func _physics_process(delta: float) -> void:
	var rotation_diff = rotation_amount - rotation_center.rotation.y
	if abs(rotation_diff) > 0.001:
		var sign = abs(rotation_diff) / rotation_diff
		var abs_rotation_delta = min(abs(rotation_diff), ROTATION_AMOUNT_PER_SECOND * delta)
		rotation_center.rotation.y += sign * abs_rotation_delta

func set_rotation_amount(amount: String) -> void:
	if not amount.is_valid_int():
		return
	rotation_amount = deg_to_rad(int(amount) + 45)

func get_rotation_amount() -> String:
	return str(int(rad_to_deg(rotation_amount) - 45))
