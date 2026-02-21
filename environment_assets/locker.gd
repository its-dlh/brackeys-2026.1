extends Node3D

@export var locker_name: String = "A.A. Aaronson"
@export var locker_code: String = ""
@export var open_dialogue: DialogueResource = load("res://words/opening_room/locker_empty.dialogue")

@onready var interactable = $Interactable
@onready var locker_state_key: String = "locker_opened:" + locker_name
@onready var code_correct_dialogue = DialogueManager.create_resource_from_text("~ start\nYou entered the code successfully, and you open the locker.")
@onready var code_incorrect_dialogue = DialogueManager.create_resource_from_text("~ start\nYou did not enter the correct code.")
@onready var animation_player = $AnimationPlayer

func prompt_for_code() -> void:
	_do_prompt_for_code.call_deferred()

func _do_prompt_for_code() -> void:
	var entered_code = await interactable.prompt("Enter locker code")
	if locker_code and entered_code == locker_code:
		DialogueManager.show_dialogue_balloon(code_correct_dialogue)
		await DialogueManager.dialogue_ended
		open_locker()
	else:
		DialogueManager.show_dialogue_balloon(code_incorrect_dialogue)

func open_locker() -> void:
	animation_player.play("DoorAction")
	SoundEffects.play_squeaky_locker_sound()
	RoomState.set_value(locker_state_key, true)
	show_open_dialogue()

func show_open_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(open_dialogue, "start", [self])
