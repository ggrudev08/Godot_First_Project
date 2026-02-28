extends Area2D

signal player_entered
signal player_exited


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_exited.emit(body)
		print("Player exited")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered.emit(body)
		print("Player entered")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
