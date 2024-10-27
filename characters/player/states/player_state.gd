class_name PlayerState extends State

const IDLE = "idle"
const WALK = "walk"
const RUN = "run"

var player : Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "Obiekt typu PlayerState może być użyty tylko w scenie gracza. 
		Jako ownera potrzebuje obiektu Player")
