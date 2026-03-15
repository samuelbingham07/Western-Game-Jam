extends CharacterBody2D

@export var speed := 60.0
@export var stop_distance := 200.0
@export var shoot_cooldown := 1.0
@export var max_health := 10

var player: Node2D = null
var shoot_timer := 0.0
var health := 10
var bullet_scene = preload("res://Scenes/bullet.tscn")

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().root.find_child("CharacterBody2D", true, false)

func _physics_process(delta: float) -> void:
	if player == null:
		return

	var distance = global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()

	if distance > stop_distance + 20:
		velocity = direction * speed
	elif distance < stop_distance - 20:
		velocity = -direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	shoot_timer += delta
	if shoot_timer >= shoot_cooldown:
		shoot_timer = 0.0
		shoot()

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.rotation = global_position.angle_to_point(player.global_position)
	bullet.speed_multiplier = 2.0
	get_tree().root.add_child(bullet)

func take_damage(amount: int) -> void:
	health -= amount
	print("boss health: ", health)
	if health <= 0:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	take_damage(1)
