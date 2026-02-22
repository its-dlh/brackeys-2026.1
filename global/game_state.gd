extends Node

signal state_changed(key, value, prev_value, state: Dictionary)

enum {
	HAS_LEFT_ARM,
	HAS_RIGHT_ARM,
	HAS_OILED_LEGS,
	HAS_RED_KEY,
	IS_LOCKDOWN_CLEARED
}

var state: Dictionary = {}

func set_value(key, value) -> void:
	var prev_value = state.get(key, null)
	state[key] = value
	state_changed.emit(key, value, prev_value, state)
	print('State: ', key, ' changed from ', prev_value, ' to ', value)

func get_value(key):
	return state.get(key, null)
