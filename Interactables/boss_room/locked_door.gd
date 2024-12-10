class_name LockedDoor extends Node2D


var is_open : bool = false

@export var key_item : ItemData #What type of item can open me?

@export var locked_audio : AudioStream
@export var open_audio : AudioStream

func _ready() -> void:
	pass
