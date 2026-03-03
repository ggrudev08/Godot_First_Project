extends Node

const MAX_HEALTH = 6
var current_health = MAX_HEALTH

signal health_depleted

func _on_player_hit():
	current_health -= 1
	print(current_health)
	if current_health <= 0:
		health_depleted.emit()
	


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
