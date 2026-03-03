extends CharacterBody2D

const SPEED = 100

@onready var animated_sprite = $AnimatedSprite2D
@onready var player_health = $Health
var is_dead = false


func die():
	is_dead = true
	#dying animation
	var direction := Input.get_vector("move_left", "move_right",
	 "move_up", "move_down")
	
	if direction == Vector2.ZERO:
		animated_sprite.play("dying_down")
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("dying_right")
		else:
			animated_sprite.play("dying_left")
	else:
		if direction.y < 0:
			animated_sprite.play("dying_up")
		else:
			animated_sprite.play("dying_down")
	await $AnimatedSprite2D.animation_finished
	
	#respawn
	self.global_position = Vector2(0, 12)
	player_health.current_health = player_health.MAX_HEALTH
	is_dead = false

func _on_health_depleted():
	die()	
	

func _physics_process(delta: float) -> void:	
	if is_dead:
		return
	
	# get_vector(left, right, up, down)
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
