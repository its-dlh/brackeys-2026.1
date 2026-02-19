extends Node

@onready var current_rooom_scene_path: String = get_tree().current_scene.scene_file_path

func _ready() -> void:
	get_tree().scene_changed.connect(_on_scene_changed)

func _on_scene_changed(scene: PackedScene) -> void:
	var previous_rooom_scene_path = current_rooom_scene_path
	current_rooom_scene_path = scene.scene_file_path

	var entrance_node = null

	for node in get_tree().get_nodes_in_group("entrance"):
		if node.connected_room == previous_rooom_scene_path:
			entrance_node = node
			break

	if entrance_node:
		move_player_to_entrance(entrance_node)
	else:
		print("Warning: No entrance node found in ", current_rooom_scene_path, " coming from ", previous_rooom_scene_path)

func move_player_to_entrance(entrance_node: Node3D) -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.global_position = entrance_node.global_position + entrance_node.entrance_offset

func go(room: PackedScene) -> void:
	get_tree().change_scene_to_packed(room)
