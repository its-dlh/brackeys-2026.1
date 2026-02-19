@tool
extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		# Hide all editor_only nodes if we're in the game
		for node in get_tree().get_nodes_in_group("editor_only"):
			node.visible = false
