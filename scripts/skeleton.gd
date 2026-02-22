extends CharacterBody2D

const SPEED = 60

@export var target: Node2D = null

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	call_deferred("seeker_setup")
	
func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position
		
func _physics_process(delta: float) -> void:
	if target:
		navigation_agent_2d.target_position = target.global_position
		var direction: Vector2 = navigation_agent_2d.target_position - target.global_position
		
			
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_pos = global_position
	var next_pos = navigation_agent_2d.get_next_path_position()
	velocity = current_pos.direction_to(next_pos) * SPEED
	
	if velocity > Vector2.ZERO:
		animated_sprite.play("running")
	else:
		animated_sprite.play("idle")
	
	animated_sprite.flip_h = false if velocity.x > 0 else true
	move_and_slide()
