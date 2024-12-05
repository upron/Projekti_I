extends Node

signal tilemap_bounds_changed( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func change_tilemap_bounds( bounds : Array[ Vector2 ] ) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit( bounds )
