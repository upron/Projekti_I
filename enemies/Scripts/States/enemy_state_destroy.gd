class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://Items/Item_pickup/item_pickup.tscn")

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export_category("Item Drops")
@export var drops : Array[DropData]

var _damage_position : Vector2
var _direction : Vector2

## What happens when we initialize this state?
func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	print("EnemyStateDestroy initialized, enemy_destroyed connected.")
	pass


## What happens when the enemy enters this State?
func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	print("Entered destroy state. Animation started.")
	disable_hurt_box()
	disable_attack_area()
	disable_vision_area()
	drop_items()
	pass


## What happens when the enemy exits this State?
func exit() -> void:
	print("Exiting destroy state.")
	pass


## What happens during the _process update in this State?
func process(_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null


## Handle animation finish
func _on_animation_finished(_a: String) -> void:
	print("Animation finished. Queue freeing enemy.")
	disable_attack_area()
	disable_vision_area()
	enemy.queue_free()
	pass


func disable_hurt_box() -> void:
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
		print("Hurt box disabled.")


func disable_attack_area() -> void:
	var attack_area : AttackArea = enemy.get_node_or_null("AttackArea")
	if attack_area:
		attack_area.monitoring = false
		print("Attack area disabled.")


func disable_vision_area() -> void:
	var vision_area : VisionArea = enemy.get_node_or_null("VisionArea")
	if vision_area:
		vision_area.monitoring = false
		print("Vision area disabled.")


func drop_items() -> void:
	if drops.size() == 0:
		print("No items to drop.")
		emit_signal("enemy_died")
		return

	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
		var drop_count: int = drops[i].get_drop_count()
		for j in drop_count:
			var drop: ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			enemy.get_parent().call_deferred("add_child", drop)
			drop.global_position = enemy.global_position
			drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
	print("Items dropped.")
	emit_signal("enemy_died")
	pass


func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	print("Enemy destroyed signal received, attempting state change.")
	state_machine.change_state(self)
