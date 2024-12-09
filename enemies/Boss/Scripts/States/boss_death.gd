class_name BossStateDestroy extends BossState



@export var anim_name : String = "death"
@export var knockback_speed : float = 50.0
@export var decelerate_speed : float = 10.0

@export_category("AI")


var _damage_position : Vector2
var _direction : Vector2

## What happens when we initialize this state?
func init() -> void:
	boss.boss_destroyed.connect(_on_boss_destroyed)
	pass
	
	
## What happens when the enemy enters this State?
func enter() -> void:
	boss.invulnerable = true
	_direction = boss.global_position.direction_to( _damage_position)
	boss.set_direction( _direction )
	boss.velocity = _direction * - knockback_speed
	boss.update_animation( anim_name )
	boss.animation_player.animation_finished.connect(_on_animation_finished)
	disable_hurt_box()
	#drop_items()
	pass
	
	
## What happens when the enemy exits this State?
func exit() -> void:
	pass
	
	
## What happens during the _process update in this State?
func process( _delta : float ) -> BossState:
	boss.velocity -= boss.velocity * decelerate_speed * _delta
	return null
	
	
## What happens during the _physics_process update in this State?
func physics( _delta : float ) -> BossState:
	return null
	
func _on_boss_destroyed( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )
	
func _on_animation_finished ( _a : String ) -> void:
	boss.queue_free()
	
func disable_hurt_box() -> void:
	var hurt_box : HurtBox = boss.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
		
#func drop_items() -> void:
	#if drops.size() == 0:
	#	return
		
	#for i in drops.size():
		#if drops[ i ] == null or drops[ i ].item == null:
			#continue
		#var drop_count : int = drops[ i ].get_drop_count()
		#for j in drop_count:
			#var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			#drop.item_data = drops[ i ].item
			#enemy.get_parent().call_deferred( "add_child", drop )
			#drop.global_position = enemy.global_position
			#drop.velocity = enemy.velocity.rotated( randf_range( -1.5, 1.5 ) ) * randf_range( 0.9 , 1.5 )
	#pass
