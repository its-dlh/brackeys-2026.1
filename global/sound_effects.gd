extends Node

@onready var door_player = $DoorPlayer

func play_door_sound() -> void:
	door_player.play()
