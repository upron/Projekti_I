extends Node

<<<<<<< Updated upstream
signal level_load_started
signal level_loaded
signal tilemap_bounds_changed( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]
var target_transition : String
var position_offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()
=======
signal tilemap_bounds_changed( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
>>>>>>> Stashed changes
	pass # Replace with function body.

func change_tilemap_bounds( bounds : Array[ Vector2 ] ) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit( bounds )
<<<<<<< Updated upstream
	
func load_new_level(
		level_path : String,
		_target_transition : String,
		_position_offset : Vector2

) -> void:
	
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await get_tree().process_frame
	
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file( level_path )
	
	await get_tree().process_frame
	
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
	
	
	pass
=======
>>>>>>> Stashed changes
