extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity = Vector2.ZERO
	player.flip_idle()
	player.turn_on_idle()
	player.animation.play("idle")

func physics_update(_delta: float) -> void:
	player.move_and_slide()
	
	# Wciśnięcie jednocześnie klawiszy ruchu powoduje pozostanie w stanie bezczynności
	if (Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right")) or \
			(Input.is_action_pressed("move_up") and Input.is_action_pressed("move_down")):
		return
	
	# Zmiana stanu
	if Input.is_action_pressed("run") and (Input.is_action_pressed("move_left") or \
			Input.is_action_pressed("move_right") or \
			Input.is_action_pressed("move_up") or \
			Input.is_action_pressed("move_down")):
		finished.emit(RUN) # Bieganie
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or \
			Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		finished.emit(WALK) # Chodzenie
