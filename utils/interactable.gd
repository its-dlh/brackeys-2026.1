extends Area3D

@export var dialogue: DialogueResource

@export_group("Navigation")
@export var should_navigate: bool = true
@export var target_offset: Vector3 = Vector3.ZERO
@export var acceptable_distance: float = 1.5

@onready var navigation_target = Vector3(global_position.x, 0.0, global_position.z) + target_offset

signal interaction_started

var player: CharacterBody3D
var player_en_route: bool = false

func _ready() -> void:
	connect_to_related_collision_objects()

	if should_navigate:
		navigation_setup()

func navigation_setup() -> void:
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")
	player.navigation_agent.target_reached.connect(_on_navigation_target_reached)
	player.navigation_agent.navigation_finished.connect(_on_player_navigation_finished)

func connect_to_related_collision_objects() -> void:
	if get_parent().is_class("CollisionObject3D"):
		connect_to_collision_object(get_parent())

	var collision_objects = get_parent().find_children("*", "CollisionObject3D", true);
	for collision_object in collision_objects:
		if collision_object != self:
			connect_to_collision_object(collision_object)

func connect_to_collision_object(collision_object: CollisionObject3D) -> void:
	collision_object.input_event.connect(_input_event)
	print('Collision object: ', collision_object.name)

func _input_event(_camera: Camera3D, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not should_navigate:
			perform_interaction()
			return

		player_en_route = true
		player.navigate_to(navigation_target, acceptable_distance)
		print('Player en route')

func _on_navigation_target_reached() -> void:
	if player_en_route and player.navigation_agent.target_position == navigation_target:
		player_en_route = false
		perform_interaction()

func _on_player_navigation_finished() -> void:
	if player_en_route:
		player_en_route = false

func perform_interaction() -> void:
	print("Interacting with ", name)
	interaction_started.emit()

	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, "start", [self,{ parent = get_parent() }])
