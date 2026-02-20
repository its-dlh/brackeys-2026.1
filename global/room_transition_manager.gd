extends Node

@onready var current_room_scene_path: String = get_tree().current_scene.scene_file_path

func go_to_entrance(connection_id: String) -> void:
	var entrance_node = null

	for node in get_tree().get_nodes_in_group("entrance"):
		print("Comparing connection IDs: ", node.connection_id, " and ", connection_id)
		if node.connection_id == connection_id:
			entrance_node = node
			break

	if entrance_node:
		move_player_to_entrance(entrance_node)
	else:
		print("Warning: No entrance node found with connection ID: ", connection_id)

func move_player_to_entrance(entrance_node: Node3D) -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.global_position = entrance_node.to_global(entrance_node.entrance_offset)
	print("Player moved to entrance: ", player.global_position)

func go(room_path: String, connection_id: String) -> void:
	print("Going to room: ", room_path)
	get_tree().change_scene_to_file(room_path)
	await get_tree().scene_changed

	if connection_id:
		go_to_entrance(connection_id)
	else:
		print("Warning: No connection ID provided for room: ", room_path)
