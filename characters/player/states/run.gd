extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.flip_run()
	player.turn_on_run()
	player.animation.play("run")
	

func physics_update(_delta : float) -> void:
	# Kierunek i szybkość
	var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction.normalized()
	player.velocity = direction * player.speed_run
	
	# Obrót postaci lewo-prawo
	# Jeżeli postać jest skierowana w prawo ale idziemy w lewo
	if direction.x < 0 and not player.character_flip:
		player.character_flip = true
		player.flip_run()
	# Jeżeli postać jest skierowana w lewo ale idziemy w prawo
	elif direction.x > 0 and player.character_flip:
		player.character_flip = false
		player.flip_run()
	
	# Ruch
	player.move_and_slide()
	
	# Zmiana stanu
	if direction == Vector2.ZERO:
		finished.emit(IDLE) # Bezczynność
	elif not Input.is_action_pressed("run"):
		finished.emit(WALK) # Chodzenie
