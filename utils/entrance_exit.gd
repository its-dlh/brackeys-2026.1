extends Node3D

## The scene that the game will load when the player touches the magic invisible exit box
@export var connected_room: PackedScene
@export var entrance_offset: Vector3 = Vector3(2.5, 0, 0)

@onready var trigger_area = $ExitArea3D

func _ready() -> void:
	trigger_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	print("Body entered exit area: ", body.name)
	if body.is_in_group("player"):
		print("Player entered exit area")
		RoomTransitionManager.go(connected_room)
