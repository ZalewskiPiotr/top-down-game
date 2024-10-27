extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.turn_on_walk()
	player.animation.play("walk")
	

func physics_update(_delta : float) -> void:
	# Kierunek i szybkość
	var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction.normalized()
	player.velocity = direction * player.speed_walk
	
	# Ruch
	player.move_and_slide()
	
	# Przejście do bezczynności
	if direction == Vector2.ZERO:
		finished.emit(IDLE)
