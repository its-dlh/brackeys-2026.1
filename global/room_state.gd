extends Node

signal state_changed(key: String, value, prev_value, room_state: Dictionary)

var state: Dictionary = {}

func get_room_state() -> Dictionary:
  var scene_path = get_tree().current_scene.scene_file_path
  if not state.has(scene_path):
    state[scene_path] = {}
  return state[scene_path]

func set_value(key: String, value) -> void:
  var room_state = get_room_state()
  var prev_value = room_state.get(key, null)
  room_state[key] = value
  state_changed.emit(key, value, prev_value, room_state)
  print('Room state: ', room_state)

func get_value(key: String):
  var room_state = get_room_state()
  return room_state.get(key, null)

