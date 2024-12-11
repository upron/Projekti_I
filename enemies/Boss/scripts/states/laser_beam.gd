extends BossState

@onready var pivot: Node2D = $"../../Pivot"
var can_transition: bool = false

func enter():
	super.enter()
	await play_animation("laser_cast")
	await play_animation("laser")
	can_transition = true
 
func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished
 
func set_target():
	var target_angle = (owner.direction - pivot.position).angle()
	pivot.rotation = lerp_angle(pivot.rotation, target_angle, 0.8)  # 0.1 määrittää nopeuden
	
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
