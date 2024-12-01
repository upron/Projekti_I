class_name state extends Node

# Stores a reference to the player that this State belongs to
static var player: Player


func _ready() -> void:
	pass # Replace with function body.

func  Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> state:
	return null
	
	
func Physics( _delta : float ) -> state:
	return null

func HandleInput( _event : InputEvent ) -> state:
	return null
	
