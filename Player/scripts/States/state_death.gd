class_name State_Death extends State

@export var exhaust_audio : AudioStream
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

## What happens when we initialize this state?
func init() -> void:
	pass
	
func enter() -> void:
	player.animation_player.play( "death" )
	audio.stream = exhaust_audio
	audio.play()
	PlayerHub.show_game_over_screen()
	AudioManager.play_music( null )
	pass
