extends Node2D

const SPEED := 300

func _ready() -> void:
	# ignore collisions for first 0.1s so bullet clears the shooter
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.2).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
