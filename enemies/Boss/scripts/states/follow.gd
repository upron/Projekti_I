extends BossState

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle")
 
func exit():
	super.exit()
	owner.set_physics_process(false)
	
func transition():
	var distance = owner.direction.length()
 
	if distance < 30:
		get_parent().change_state("MeleeAttack")
	elif distance > 100:
		var chance = randi() % 2
		match chance:
			
			1:
				get_parent().change_state("LaserBeam")
