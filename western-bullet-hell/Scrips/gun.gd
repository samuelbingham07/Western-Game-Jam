extends Node2D

var gun_jammed = false
<<<<<<< HEAD
<<<<<<< HEAD


=======
var available_bullets = 0
>>>>>>> parent of f92461a (change layers)
=======
var available_bullets = 0
>>>>>>> parent of f92461a (change layers)
@export var max_bullets = 6
@onready var Bullet = preload("res://Scenes/bullet.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun_shoots: AudioStreamPlayer2D = $GunShoots
@onready var gun_jams: AudioStreamPlayer2D = $GunJams

func _ready() -> void:
	Global.available_bullets = max_bullets

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	if get_global_mouse_position().x < global_position.x:
		scale.y = -1
	else:
		scale.y = 1

	if Input.is_action_just_pressed("shoot") and Global.available_bullets < 1:
		animated_sprite_2d.play("gun_jamming")
		gun_jams.play()

	if Input.is_action_just_pressed("shoot") and Global.available_bullets > 0:
		var bullet_instance = Bullet.instantiate()
<<<<<<< HEAD
=======
		bullet_instance.from_player = true  
		get_tree().root.add_child(bullet_instance)
>>>>>>> 47b19ce5be377697124563a2aeec75de227bb619
		bullet_instance.speed_multiplier = 1.0 
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position.x = global_position.x + 10
		bullet_instance.global_position.y = global_position.y - 10
		bullet_instance.rotation = rotation
		animated_sprite_2d.play("shoot")
		gun_shoots.play()
		Global.available_bullets -= 1

	reload()

func reload():
	if Input.is_action_just_pressed("reload"):
		Global.available_bullets = max_bullets
