extends CharacterBody2D
 
signal enemy_damaged( hurt_box : HurtBox )
signal  enemy_destroyed( hurt_box : HurtBox ) 

@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/ProgressBar
@onready var hit_box: HitBox = $HitBox

var player : Player 
var direction : Vector2
var hurtbox : HurtBox 

var hp = 35:
	set(value):
		hp = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")

func _ready():
	player = PlayerManager.player
	set_physics_process(false)
	hit_box.damaged.connect( _take_damage )
 
func _process(_delta):
	
	direction = player.position - position
 
	if direction.x < 0:
		sprite.flip_h = true
		$Sprite2D/HurtBox.position.x = -abs($Sprite2D/HurtBox.position.x) # Tee X-arvosta negatiivinen
	else:
		sprite.flip_h = false
		$Sprite2D/HurtBox.position.x = abs($Sprite2D/HurtBox.position.x) # Tee X-arvosta positiivinen
 
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
	
func _take_damage (hurt_box : HurtBox) -> void:
	hp -= hurt_box.damage
	if hp > 0:
		enemy_damaged.emit( hurt_box )
	else:
		enemy_destroyed.emit( hurt_box )
