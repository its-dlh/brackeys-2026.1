extends Area3D

@export var shape: Shape3D
@export var should_navigate: bool = true
@export var dialogue: DialogueResource

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

signal interaction_started

var player: CharacterBody3D
var player_en_route: bool = false

func _ready() -> void:
	if not shape:
		shape = get_sibling_shape()
		print('Shape: ', shape)
		collision_shape.shape = shape


	if should_navigate:
		# TODO find a better way to get player node while still safely waiting for it to be ready
		player = get_node("/root/MovementTestSceen/Player")
		await player.ready
		player.navigation_agent.navigation_finished.connect(_on_player_navigation_finished)


func get_sibling_shape() -> Shape3D:
	var parent = get_parent()
	if parent:
		return parent.get_node("CollisionShape3D").shape
	return null

func _input_event(_camera: Camera3D, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if not should_navigate:
		perform_interaction()
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		player_en_route = true
		player.navigate_to(global_position)
		print('Player en route')

func _on_player_navigation_finished() -> void:
	if player_en_route:
		player_en_route = false
		perform_interaction()

func perform_interaction() -> void:
	print("Interacting with ", name)
	interaction_started.emit()

	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, "start")
