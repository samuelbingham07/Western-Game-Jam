extends Node2D

var gun_jammed = false
var available_bullets = 0
@export var max_bullets = 6

@onready var Bullet = preload("res://Scenes/bullet.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	available_bullets = max_bullets


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if global_rotation < -4 and global_rotation > 1:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		
	print(global_rotation)
	
	if Input.is_action_just_pressed("shoot") and available_bullets < 1:
		animated_sprite_2d.play("gun_jamming")
	
	if Input.is_action_just_pressed("shoot") and available_bullets > 0:
		var bullet_instance = Bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.rotation = rotation
		animated_sprite_2d.play("shoot")
		available_bullets -= 1
	reload()

func reload():
	if Input.is_action_just_pressed("reload"):
		available_bullets = max_bullets
