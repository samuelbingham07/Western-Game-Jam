extends Node2D

const SPEED := 300
var speed_multiplier := 1.0

func _ready() -> void:
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.3).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _process(delta: float) -> void:
	position += transform.x * SPEED * speed_multiplier * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
