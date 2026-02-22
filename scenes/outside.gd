extends Node3D

@onready var resource: DialogueResource = load("res://words/end-game.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(resource)
	if MusicPlayer.playing:
		MusicPlayer.stop()
