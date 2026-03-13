extends Node2D

@onready var Bullet = preload("res://Scenes/bullet.tscn")

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = Bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.rotation = rotation
