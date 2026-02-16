extends CollisionObject3D

@onready var player = get_node("/root/MovementTestSceen/Player")

func _input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Floor click at: ", event_position)
		print("Player position: ", player.global_position)
		player.navigate_to(Vector3(event_position.x, 0, event_position.z))
