extends Area2D

@onready var timer = $Timer

signal player_hit

var player_inside : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false

func _physics_process(delta: float) -> void:
	attack_player()

func attack_player():
	if player_inside && timer.time_left <= 0:
		player_hit.emit()
		timer.start(0.5)
