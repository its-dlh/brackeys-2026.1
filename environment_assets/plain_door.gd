extends Node3D

@export var dialogue: DialogueResource
@export var open_state_key: String = "door_open"
@export var start_open: bool = false
@export var nodes_to_reveal: Array[Node3D] = []
@export var nodes_to_hide: Array[Node3D] = []

@onready var interactable = $Interactable
@onready var door_mesh: MeshInstance3D = $MeshInstance3D
@onready var door_collision_shape: CollisionShape3D = $StaticBody3D/CollisionShape3D

var has_been_open: bool = false

const DOOR_OPEN_AMOUNT = 1.4
const DOOR_OPEN_SPEED = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if start_open:
		RoomState.set_value(open_state_key, true)
	if is_door_open():
		door_mesh.position.x = DOOR_OPEN_AMOUNT

	# Reflect the initial state of the door
	_on_open_state_changed(is_door_open())
	# Reflect future state changes
	RoomState.state_changed.connect(_on_state_changed)

	if dialogue:
		interactable.dialogue = dialogue

func _physics_process(delta: float) -> void:
	if is_door_open():
		if door_mesh.position.x < DOOR_OPEN_AMOUNT:
			door_mesh.position.x += DOOR_OPEN_SPEED * delta
		else:
			door_mesh.position.x = DOOR_OPEN_AMOUNT
	else:
		if door_mesh.position.x > 0.0:
			door_mesh.position.x -= DOOR_OPEN_SPEED * delta
		else:
			door_mesh.position.x = 0.0

func _on_state_changed(key, value, prev_value, _state) -> void:
	if key == open_state_key and value != prev_value:
		_on_open_state_changed(value)

func _on_open_state_changed(is_open: bool) -> void:
	if is_open:
		print('Reflecting door state: open')
		door_collision_shape.set_deferred("disabled", true)

		if not has_been_open:
			has_been_open = true
			for node in nodes_to_reveal:
				node.visible = true
			for node in nodes_to_hide:
				node.visible = false
	else:
		print('Reflecting door state: closed')
		door_collision_shape.set_deferred("disabled", false)

		if not has_been_open:
			for node in nodes_to_reveal:
				node.visible = false

func open_door() -> void:
	if not start_open:
		SoundEffects.play_door_sound()
	RoomState.set_value(open_state_key, true)

func close_door() -> void:
	RoomState.set_value(open_state_key, false)

func is_door_open() -> bool:
	return RoomState.get_value(open_state_key) == true
