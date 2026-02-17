extends Area3D

@export var shape: Shape3D
@export var dialogue: DialogueResource

@export_group("Navigation")
@export var should_navigate: bool = true
@export var target_offset: Vector3 = Vector3.ZERO
@export var acceptable_distance: float = 2.0

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var navigation_target = global_position + target_offset

signal interaction_started

var player: CharacterBody3D
var player_en_route: bool = false

func _ready() -> void:
	if not shape:
		shape = get_sibling_shape()
		print('Shape: ', shape)
		collision_shape.shape = shape

	if should_navigate:
		navigation_setup()

func navigation_setup() -> void:
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")
	player.navigation_agent.target_reached.connect(_on_navigation_target_reached)
	player.navigation_agent.navigation_finished.connect(_on_player_navigation_finished)

func get_sibling_shape() -> Shape3D:
	var parent = get_parent()
	if parent:
		return find_node_recursive(parent, "CollisionShape3D").shape
	return null

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

func find_node_recursive(current_node: Node, target_name: String) -> Node:
	if current_node.name == target_name:
		return current_node

	for child in current_node.get_children():
		var found_node = find_node_recursive(child, target_name)
		if found_node:
			return found_node
	
	return null
