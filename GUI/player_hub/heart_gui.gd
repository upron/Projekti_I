class_name HeartGUI extends Control

@onready var sprite: Sprite2D = $Sprite2D

var value: int = 2:
	set(new_value):
		_value = clamp(new_value, 0, 2)  # Varmistetaan, että arvo pysyy välillä [0, 2]
		update_sprite()

var _value: int = 2

func update_sprite() -> void:
	if sprite:
		sprite.frame = _value
