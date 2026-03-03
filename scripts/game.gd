extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Skeleton/DamageZone.player_hit.connect($Player/Health._on_player_hit)
	$Player/Health.health_depleted.connect($Player._on_health_depleted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
