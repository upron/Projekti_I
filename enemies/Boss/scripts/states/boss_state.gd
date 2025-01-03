class_name BossState extends Node


@onready var debug = owner.find_child("debug")
@onready var player : Player
@onready var animation_player = owner.find_child("AnimationPlayer")
 
func _ready():
	set_physics_process(false)
 
func enter():
	set_physics_process(true)
 
func exit():
	set_physics_process(false)
 
func transition():
	pass
 
func _physics_process(_delta):
	transition()
	debug.text = name
