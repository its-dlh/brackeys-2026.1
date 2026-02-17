extends Node

signal state_changed(key: String, value: bool, room_state: Dictionary)

var state: Dictionary = {}

func get_room_state() -> Dictionary:
  var scene_path = get_tree().current_scene.scene_file_path
  if not state.has(scene_path):
    state[scene_path] = {}
  return state[scene_path]

func set_value(key: String, value: bool) -> void:
  var room_state = get_room_state()
  room_state[key] = value
  state_changed.emit(key, value, room_state)
  print('Room state: ', room_state)

func get_value(key: String) -> bool:
  var room_state = get_room_state()
  return room_state.get(key, false)

