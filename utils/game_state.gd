extends Node

signal state_changed(flag: Flags, value: bool, state: Dictionary)

enum Flags {
	HAS_LEFT_ARM,
	ROOM1_DOOR_OPEN
}

var state: Dictionary = {}

func set_value(flag: Flags, value: bool) -> void:
	state[flag] = value
	state_changed.emit(flag, value, state)
	print('State: ', state)

func get_value(flag: Flags) -> bool:
	return state.get(flag, false)

