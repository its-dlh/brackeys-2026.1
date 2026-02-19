extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide all editor_only nodes if we're in the game
	for node in get_tree().get_nodes_in_group("editor_only"):
		node.visible = false
