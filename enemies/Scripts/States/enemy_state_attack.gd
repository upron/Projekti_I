class_name EnemyStateAttack extends EnemyState

@onready var wander: EnemyStateWander = $"../Wander"
@export var turn_rate : float = 0.25
@export_range(1,20,0.5)  var decelerate_speed : float = 5.0

@export_category("AI")
@export var attack_area : AttackArea
@export var next_state : EnemyState
@export var hurt_box : HurtBox

var attacking : bool = false 
var _can_see_player : bool = false

## What happens when we initialize this state?
func init() -> void:
	if attack_area:
		attack_area.attack_entered.connect( _on_player_enter )
		attack_area.attack_exited.connect( _on_player_exit )
	pass
	
	
## What happens when the enemy enters this State?
func enter() -> void:
	enemy.update_animation( "attack" )
	
	hurt_box.monitoring = true
	pass
	
	
## What happens when the enemy exits this State?
func exit() -> void:
	attacking = false
	hurt_box.monitoring = false
	pass
	
	
## What happens during the _process update in this State?
func process( _delta : float ) -> EnemyState:
	enemy.velocity = Vector2.ZERO
	
	if _can_see_player == false:
			return next_state
	return null
	
	
## What happens during the _physics_process update in this State?
func physics( _delta : float ) -> EnemyState:
	return null
	
func _on_player_enter() -> void:
	_can_see_player = true
	if state_machine.current_state is EnemyStateStun:
		return
	state_machine.change_state( self )
	pass


func _on_player_exit() -> void:
	_can_see_player = false
	attacking = false
	pass
