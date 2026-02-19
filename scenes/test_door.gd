extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if RoomState.get_value("door_open"):
		open_door()

func open_door() -> void:
	rotate_y(-1.5)
