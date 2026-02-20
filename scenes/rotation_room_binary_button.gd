extends StaticBody3D

@export var starting_bitfield: int = 5

@onready var flat_plat_1 = $"../FlatPlat"
@onready var flat_plat_2 = $"../FlatPlat2"
@onready var flat_plat_3 = $"../FlatPlat3"
@onready var flat_plat_4 = $"../FlatPlat4"

# 5 is the good path
var bitfield: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bitfield = starting_bitfield
	sync_platforms()


func _on_interactable_interaction_started() -> void:
	bitfield = max(bitfield + 1, 15)
	sync_platforms()

func sync_platforms() -> void:
	#use bitfield to determine which platforms to activate
	flat_plat_1.position.y = (2.5) if (bitfield & 0b1000) else 0.0
	flat_plat_2.position.y = (2.5) if (bitfield & 0b0100) else 0.0
	flat_plat_3.position.y = (2.5) if (bitfield & 0b0010) else 0.0
	flat_plat_4.position.y = (2.5) if (bitfield & 0b0001) else 0.0
