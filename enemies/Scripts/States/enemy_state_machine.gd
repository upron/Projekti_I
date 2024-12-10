class_name EnemyStateMachine extends Node

var states: Array[EnemyState]
var prev_state: EnemyState
var current_state: EnemyState

func _ready():
	# Alustetaan prosessointi oikein
	process_mode = Node.PROCESS_MODE_DISABLED
	print("EnemyStateMachine initialized.")
	pass


func _process(delta):
	# Varmistetaan, että current_state on olemassa
	if current_state:
		var new_state = current_state.process(delta)
		if new_state:
			change_state(new_state)
	pass


func _physics_process(delta):
	# Varmistetaan, että current_state on olemassa
	if current_state:
		var new_state = current_state.physics(delta)
		if new_state:
			change_state(new_state)
	pass


func initialize(_enemy: Enemy) -> void:
	# Alustetaan tilalistat ja liitetään tilat viholliseen
	states = []
	for c in get_children():
		if c is EnemyState:
			states.append(c)

	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()

	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
		print("Initialized with initial state: ", states[0])
	else:
		print("No states found to initialize.")
	pass


func change_state(new_state: EnemyState) -> void:
	# Varmistetaan, että tilasiirrot tapahtuvat vain tarvittaessa
	if new_state == null:
		print("Attempted to change to a null state.")
		return

	if new_state == current_state:
		print("New state is same as the current state, skipping.")
		return

	# Poistetaan nykyisen tilan logiikka ja siirrytään uuteen tilaan
	if current_state:
		print("Exiting current state: ", current_state)
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	print("Changing to new state: ", new_state)
	current_state.enter()
