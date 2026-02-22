extends Node

@onready var door_player = $DoorPlayer
@onready var squeaky_locker_player = $SqueakyLockerPlayer
@onready var take_item_player = $TakeItemPlayer

func play_door_sound() -> void:
	door_player.play()

func play_squeaky_locker_sound() -> void:
	squeaky_locker_player.play()

func play_take_arm_sound() -> void:
	take_item_player.play()
