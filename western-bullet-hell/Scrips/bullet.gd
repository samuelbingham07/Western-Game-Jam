extends Node2D

const SPEED := 300
var speed_multiplier := 1.0
<<<<<<< HEAD
=======
var from_player := false
>>>>>>> 47b19ce5be377697124563a2aeec75de227bb619

func _ready() -> void:
	if from_player:
		$Area2D.collision_layer = 1   # layer 1 - player bullet
		$Area2D.collision_mask = 2    # hits layer 2 (enemies/boss)
	else:
		$Area2D.collision_layer = 8   # layer 4 - enemy bullet
		$Area2D.collision_mask = 2    # hits layer 2 (player)

	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.3).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _process(delta: float) -> void:
	position += transform.x * SPEED * speed_multiplier * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
<<<<<<< HEAD
=======
	var parent = area.get_parent()
	if parent.has_method("take_damage"):
		parent.take_damage(1)
	elif parent.has_method("damage_dealt"):
		parent.damage_dealt(1)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
>>>>>>> 47b19ce5be377697124563a2aeec75de227bb619
	queue_free()
