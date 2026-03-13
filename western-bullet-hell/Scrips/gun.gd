extends Node2D

var gun_jammed = false

@onready var Bullet = preload("res://Scenes/bullet.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	fposmod(rotation_degrees, 360)
	
	if rotation_degrees > 90 and rotation_degrees < 270:
		#animated_sprite_2d.flip_h = true
		scale.y = -1
	else:
		#animated_sprite_2d.flip_h = false
		scale.y = 1
		
	print(rotation_degrees)
	
	if Input.is_action_just_pressed("shoot"):
		animated_sprite_2d.play("shoot")
		var bullet_instance = Bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.rotation = rotation
