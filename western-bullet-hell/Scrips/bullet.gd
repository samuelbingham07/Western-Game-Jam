extends Node2D

const SPEED := 300
var speed_multiplier := 1.0
var from_player := false  # set to true when player shoots

func _ready() -> void:
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.2).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _process(delta: float) -> void:
	position += transform.x * SPEED * speed_multiplier * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if from_player and parent.has_method("take_damage"):
		parent.take_damage(1)
		queue_free()
	elif not from_player and parent.has_method("damage_dealt"):
		parent.damage_dealt(1)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
