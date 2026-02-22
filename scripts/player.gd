extends CharacterBody2D

const SPEED = 100

func _physics_process(delta: float) -> void:
	#No gravity/jump, because it's top-down
	
	# get_vector(left, right, up, down).
	var direction := Input.get_vector("move_left", "move_right",
	 "move_up", "move_down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
