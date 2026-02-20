extends CharacterBody3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_marker: Marker3D = $CameraMarker
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var mesh: Node3D = $"player-character-v2"

const CAMERA_LAG_FACTOR = 2.5
const SPEED = 5.0
const ROTATION_SPEED = 10.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	camera_3d.global_position = camera_marker.global_position

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * SPEED
	
	# Look where we're going
	var target_angle = atan2(-velocity.x, -velocity.z) + PI # rotate 180 degrees cuz reasons
	mesh.rotation.y = lerp_angle(mesh.rotation.y, target_angle, ROTATION_SPEED * delta)

	# TODO override navigation if controls are used
	# var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# if direction:
	# 	velocity.x = direction.x * SPEED
	# 	velocity.z = direction.z * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)
	# 	velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	camera_3d.global_position = lerp(
		camera_3d.global_position,
		camera_marker.global_position,
		delta * CAMERA_LAG_FACTOR
	)

# func _input(event):
# 	# Mouse in viewport coordinates.
# 	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
# 		print("Mouse click at: ", event.position)


func navigate_to(target_position: Vector3, desired_distance: float = 0.1) -> void:
	navigation_agent.set_target_position(target_position)
	navigation_agent.target_desired_distance = desired_distance
