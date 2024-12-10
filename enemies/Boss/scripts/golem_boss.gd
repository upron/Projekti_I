extends CharacterBody2D
 
@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/ProgressBar

var player : Player 
var direction : Vector2

 
func _ready():
	player = PlayerManager.player
	set_physics_process(false)
 
func _process(_delta):
	
	direction = player.position - position
 
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
 
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
