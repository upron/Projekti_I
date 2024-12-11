extends BossState


@onready var hurt_box: HurtBox = $"../../Sprite2D/HurtBox"


func enter():
	super.enter()
	animation_player.play("melee_attack")
	
func transition():
	if owner.direction.length() > 30:
		get_parent().change_state("Follow")
