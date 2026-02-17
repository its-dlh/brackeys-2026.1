extends Node

signal state_changed(key, value, state: Dictionary)

enum {
	HAS_LEFT_ARM,
	HAS_RIGHT_ARM
}

var state: Dictionary = {}

func set_value(key, value) -> void:
	state[key] = value
	state_changed.emit(key, value, state)
	print('State: ', state)

func get_value(key):
	return state.get(key, null)

