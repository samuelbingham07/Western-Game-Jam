extends Node2D
const SPEED := 300
var speed_multiplier := 1.0
var screen_size

func _ready() -> void:
	add_to_group("bullets")
	screen_size = get_viewport_rect().size
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.3).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _process(delta: float) -> void:
	position += transform.x * SPEED * speed_multiplier * delta
	check_bounds()

func check_bounds():
	if position.x < 0 or position.x > (screen_size.x):
		queue_free()
	if position.y < 75 or position.y > (screen_size.y - 90):
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("bullet hit: ", area.get_parent(), " has take_damage: ", area.get_parent().has_method("take_damage"))
	var parent = area.get_parent()
	if parent.has_method("take_damage"):
		parent.take_damage(1)
	queue_free()
