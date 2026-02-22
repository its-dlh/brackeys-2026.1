extends Node

@onready var door_player = $DoorPlayer
@onready var squeaky_locker_player = $SqueakyLockerPlayer
@onready var take_item_player = $TakeItemPlayer
@onready var lockdown_disabled = $LockdownDisabled
@onready var lockdown_enabled = $LockdownEnabled

func play_door_sound() -> void:
	door_player.play()

func play_squeaky_locker_sound() -> void:
	squeaky_locker_player.play()

func play_take_arm_sound() -> void:
	take_item_player.play()

func play_lockdown_disabled_sound() -> void:
	lockdown_disabled.play()

func play_lockdown_enabled_sound() -> void:
	lockdown_enabled.play()
