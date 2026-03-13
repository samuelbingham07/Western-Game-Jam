extends Node2D

const SPEED := 300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	




func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
