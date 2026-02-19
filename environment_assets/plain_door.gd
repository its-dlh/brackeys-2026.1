extends Node3D

@export var dialogue: DialogueResource
@export var open_state_key: String = "door_open"

@onready var interactable = $Interactable
@onready var door_mesh: MeshInstance3D = $MeshInstance3D
@onready var door_collision_shape: CollisionShape3D = $StaticBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state_changed.connect(_on_state_changed)

	# Reflect the initial state of the door
	_on_open_state_changed(is_door_open())

	if dialogue:
		interactable.dialogue = dialogue

func _on_state_changed(key, value, prev_value, _state) -> void:
	if key == open_state_key and value != prev_value:
		_on_open_state_changed(value)

func _on_open_state_changed(is_open: bool) -> void:
	if is_open:
		door_mesh.position.x = 0.9
		door_collision_shape.set_deferred("disabled", true)
	else:
		door_mesh.position.x = 0.0
		door_collision_shape.set_deferred("disabled", false)

func open_door() -> void:
	GameState.set_value(open_state_key, true)

func close_door() -> void:
	GameState.set_value(open_state_key, false)

func is_door_open() -> bool:
	return GameState.get_value(open_state_key) == true
