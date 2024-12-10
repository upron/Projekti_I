class_name AttackArea extends Area2D

signal attack_entered()
signal attack_exited()

var player_in_area: bool = false

func _ready() -> void:
	body_entered.connect( _on_body_enter )
	body_exited.connect( _on_body_exit )
	
	
	var p = get_parent()
	if p is Enemy:
		p.direction_changed.connect( _on_direction_change )


func _on_body_enter( _b : Node2D ) -> void:
	if _b is Player:
		player_in_area = true
		print("AttackArea: Player entered area.")
		attack_entered.emit()
	pass


func _on_body_exit( _b : Node2D ) -> void:	
	if _b is Player:
		player_in_area = false
		print("AttackArea: Player exited area.")
		attack_exited.emit()
	pass
	
func _on_direction_change( new_direction : Vector2 ) -> void:
	match new_direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		_:
			rotation_degrees = 0
	pass
