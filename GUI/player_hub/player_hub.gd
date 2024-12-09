extends CanvasLayer

#@export var button_focus_audio : AudioStream = preload( "res://title_scene/audio/menu_focus.wav" )
#@export var button_select_audio : AudioStream = preload( "res://title_scene/audio/menu_select.wav" )

var hearts : Array[ HeartGUI] = []

@onready var game_over: Control = $Control/GameOver
@onready var vontinue_button: Button = $Control/GameOver/VBoxContainer/VontinueButton
@onready var tile_button: Button = $Control/GameOver/VBoxContainer/TileButton
@onready var animation_player: AnimationPlayer = $Control/GameOver/AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D



func _ready():
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append( child )
			child.visible = false

	hide_game_over_screen()
	#continue_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	#continue_button.pressed.connect( load_game )
	#title_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	#title_button.pressed.connect( title_screen )
	LevelManager.level_load_started.connect( hide_game_over_screen )


func update_hp( _hp: int, _max_hp: int ) -> void:
	update_max_hp( _max_hp )
	for i in _max_hp:
		update_heart( i, _hp )
	
func update_heart(_index: int, _hp: int) -> void:
	if _index < hearts.size():  # Tarkista, ettei ylitetä listan rajoja
		var _value: int = clamp(_hp - _index * 2, 0, 2)
		hearts[_index].value = _value
		print("Updating heart index:", _index, "to value:", _value) # Päivittää automaattisesti visuaalisen tilan
	
	
func update_max_hp( _max_hp : int ) -> void:
	var _heart_count: int = round(_max_hp * 0.5)
	for i in range(hearts.size()):  # Korjattu silmukka
		hearts[i].visible = i < _heart_count
		
func show_game_over_screen() -> void:
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var can_continue : bool = SaveManager.get_save_file() != null
	#continue_button.visible = can_continue
	
	animation_player.play("show_game_over")
	await animation_player.animation_finished
	
	#if can_continue == true:
		#continue_button.grab_focus()
	#else:
	#	title_button.grab_focus()		
		
#func load_game() -> void:
	#play_audio( button_select_audio )
	#await fade_to_black()
	#SaveManager.load_game()
	
#func title_screen() -> void:
	#play_audio( button_select_audio )
	#await fade_to_black()
	#LevelManager.load_new_level( "res://title_scene/title_scene.tscn", "", Vector2.ZERO )
		
func hide_game_over_screen() -> void:
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color( 1,1,1,0 )
	
func fade_to_black() -> bool:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	PlayerManager.player.revive_player()
	return true
				
func play_audio( _a : AudioStream ) -> void:
	audio.stream = _a
	audio.play()
