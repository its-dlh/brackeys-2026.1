extends CharacterBody3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_marker: Marker3D = $CameraMarker
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	camera_3d.global_position = camera_marker.global_position

	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.1

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * SPEED
	move_and_slide()

	camera_3d.global_position = lerp(
		camera_3d.global_position,
		camera_marker.global_position,
		delta * 2.5
	)

# func _input(event):
# 	# Mouse in viewport coordinates.
# 	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
# 		print("Mouse click at: ", event.position)


func navigate_to(target_position: Vector3) -> void:
	navigation_agent.set_target_position(target_position)
