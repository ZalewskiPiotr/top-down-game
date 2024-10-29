## Base class that extends State and stores a typed reference to the owner node. 
## There are also constants to represent the different states the character can be in 
## and help limit the risk of typos when transitioning between states.
class_name PlayerState extends State

const IDLE = "Idle"
const WALK = "Walk"
const RUN = "Run"

var player : Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "Obiekt typu PlayerState może być użyty tylko w scenie gracza. 
		Jako ownera potrzebuje obiektu Player")
