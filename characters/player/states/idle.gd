extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity = Vector2.ZERO
	player.turn_on_idle()
	player.animation.play("idle")

func physics_update(_delta: float) -> void:
	player.move_and_slide()
	
	# Wciśnięcie jednocześnie klawiszy ruchu powoduje pozostanie w stanie bezczynności
	if Input.is_action_pressed("move_left") and (Input.is_action_pressed("move_right")):
		return
	
	# Przejście do chodzenia
	if Input.is_action_pressed("move_left") or (Input.is_action_pressed("move_right")):
		finished.emit(WALK)
