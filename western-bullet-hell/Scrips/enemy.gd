extends CharacterBody2D

@export var speed := 100.0
var player: Node2D = null

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().root.find_child("CharacterBody2D", true, false)
	print("final player = ", player)

func _physics_process(delta: float) -> void:
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
