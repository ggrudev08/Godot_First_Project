extends CharacterBody2D

const SPEED = 100

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:	
	# get_vector(left, right, up, down).
	var direction := Input.get_vector("move_left", "move_right",
	 "move_up", "move_down")
	
	#Play animations
	if direction == Vector2.ZERO:
		animated_sprite.play("idle")
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("moving_right")
		else:
			animated_sprite.play("moving_left")
	else:
		if direction.y < 0:
			animated_sprite.play("moving_up")
		else:
			animated_sprite.play("moving_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
