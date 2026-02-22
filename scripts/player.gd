extends CharacterBody2D

const SPEED = 100

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	#No gravity/jump, because it's top-down
	
	# get_vector(left, right, up, down).
	var direction := Input.get_vector("move_left", "move_right",
	 "move_up", "move_down")
	
	#Flip the sprite
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
	#Play animations
	if direction == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("moving")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
