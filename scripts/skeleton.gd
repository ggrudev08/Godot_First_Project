extends CharacterBody2D

const SPEED = 50

var target: Node2D = null

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D

var can_track: bool = false

func _ready():
	call_deferred("seeker_setup")
	$ActiveRange.player_entered.connect(_on_player_entered)
	$ActiveRange.player_exited.connect(_on_player_exited)
	
func _on_player_exited(player: Node2D):
	can_track = false

func _on_player_entered(player: Node2D):
	if target == null:
		target = player	
	can_track = true	
	
func seeker_setup():
	await get_tree().physics_frame
	if target and can_track:
		navigation_agent_2d.target_position = target.global_position
		
func _physics_process(delta: float) -> void:
	if target and can_track:
		navigation_agent_2d.target_position = target.global_position
	
	if navigation_agent_2d.is_navigation_finished():
		return
	if can_track:
		var current_pos = global_position
		var next_pos = navigation_agent_2d.get_next_path_position()
		velocity = current_pos.direction_to(next_pos) * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	if velocity != Vector2.ZERO:
		animated_sprite.play("running")
	else:
		animated_sprite.play("idle")
	
	animated_sprite.flip_h = false if velocity.x > 0 else true
	move_and_slide()
