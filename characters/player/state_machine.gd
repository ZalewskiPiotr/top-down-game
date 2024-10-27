## This state machine is based on https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
## The finite state machine class uses the state. It keeps track of the active state 
## (for example, “running”) and calls the state’s functions when needed. In the game,
## the state machine will be the parent node of all states.
class_name StateMachine extends Node

## The initial state of the state machine. If not set, the first child node is used.
@export var initial_state: State = null

## The current state of the state machine.
@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()


## The states will be children of the state machine. We can use Godot’s find_children() 
## function to get all the states and connect to their finished signal to transition 
## to the next state. There, we also call the first state’s enter() function to initialize it.
func _ready() -> void:
	# Give every state a reference to the state machine.
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
	
	# State machines usually access data from the root node of the scene they're part of: the owner.
	# We wait for the owner to be ready to guarantee all the data and nodes the states may need 
	# are available.
	await owner.ready
	state.enter("")
	

## It changes the active state when the state emits the signal. Because we use nodes for states,
## we can check if a state exists using has_node() before transitioning to it.
## Then, in this function, we call the current state’s exit() function, change the active state,
## and call the new state’s enter() function. This allows the exiting state to run cleanup code
## and the entering state to initialize itself.
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + 
			" but it does not exist.")
		return
	
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)
	

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

	
func _process(delta: float) -> void:
	state.update(delta)

	
func _physics_process(delta: float) -> void:
	state.physics_update(delta)
