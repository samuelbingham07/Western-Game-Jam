extends CharacterBody2D

@export var speed := 100.0
@export var stop_distance := 300
@export var shoot_cooldown := 1.5


var player: Node2D = null
var shoot_timer := 0.0
var bullet_scene = preload("res://Scenes/enemy_bullet.tscn")
var is_ranged := false

var sprite_left = preload("res://Sprites/cactusRight.png") 
var sprite_right = preload("res://Sprites/cactusLeft.png") 

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().root.find_child("CharacterBody2D", true, false)

	if randi_range(0, 1) == 0:
		is_ranged = false
	else:
		is_ranged = true

	if is_ranged:
		var sprite = get_node_or_null("AnimatedSprite2D")
		if sprite == null:
			sprite = get_node_or_null("Sprite2D")
		if sprite:
			if global_position.x < 0:
				sprite.texture = sprite_left
			else:
				sprite.texture = sprite_right

func _physics_process(delta: float) -> void:
	if player == null:
		return

	var direction = (player.global_position - global_position).normalized()

	if is_ranged:
		var distance = global_position.distance_to(player.global_position)
		if distance > stop_distance + 20:
			velocity = direction * speed
		elif distance < stop_distance - 20:
			velocity = -direction * speed
		else:
			velocity = Vector2.ZERO

		shoot_timer += delta
		if shoot_timer >= shoot_cooldown:
			shoot_timer = 0.0
			shoot()
	else:
		velocity = direction * speed

	move_and_slide()

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.rotation = global_position.angle_to_point(player.global_position)
	get_tree().root.add_child(bullet)

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
