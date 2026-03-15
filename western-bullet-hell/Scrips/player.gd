extends CharacterBody2D

var p_health := 10
var screen_size

@onready var c_label = $Coins
@onready var h_label = $Health
@onready var restart = $RestartTimer
@onready var area = $Area2D
@onready var character = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: Node2D = $Gun
@onready var modulator: Timer = $Modulator



const ACCEL := 10.0
const WRAPPING := 40

signal health_zero

func _ready() -> void:
	screen_size = get_viewport_rect().size
	health_zero.connect(_on_health_zero)
	animated_sprite_2d.play("walk_down")

func _process(delta: float) -> void:
	
	#Carries the value of the Input Vector
	var playerInput = player_movement()
	
	#Allows the player to move smoothly by lerping the starting
	#point (velocity) to where the player is moving to (PI) by
	# a factor of ACCEL * delta
	velocity = lerp(velocity, playerInput * Global.player_speed, ACCEL * delta)
	move_and_slide()
	
	
	
	if playerInput == Vector2(1.0, 0.0):
		animated_sprite_2d.play("walk_right")
		gun.global_position.x = global_position.x + 10
		gun.visible = true
	if playerInput == Vector2(-1.0, 0.0):
		animated_sprite_2d.play("walk_left")
		gun.global_position.x = global_position.x - 10
		gun.visible = true
	if playerInput == Vector2(0.0, 1.0):
		animated_sprite_2d.play("walk_down")
		gun.global_position.x = global_position.x + 15
		gun.visible = true
	if playerInput == Vector2(0.0, -1.0):
		animated_sprite_2d.play("walk_up")
		gun.visible = false
	
	
	#wrapping()
	clamp_to_borders()
	coin_label()
	health_label()

func player_movement():
	#Assigns values of -1 and 1 to Input button maps (always normalized))
	var direction = Input.get_vector("left", "right", "up", "down")
	#Returns the value of ^ to be used in other functions
	return direction
	
func clamp_to_borders():
	position.x = clamp(position.x, 50, screen_size.x - 50)
	position.y = clamp(position.y, 100, screen_size.y - 125)

	
#func wrapping():
	#if position.x > screen_size.x + WRAPPING:
		#position.x = -WRAPPING
	#elif position.x < screen_size.x - screen_size.x - WRAPPING:
		#position.x = screen_size.x + WRAPPING
	#
	#if position.y > screen_size.y + WRAPPING:
		#position.y = -WRAPPING
	#elif position.y < screen_size.y - screen_size.y - WRAPPING:
		#position.y = screen_size.y + WRAPPING
	
func coin_label():
	c_label.text = "Coins: " + str(Global.coins)
	
func health_label():
	h_label.text = "Health: " + str(p_health)


func damage_dealt(amount):
	p_health -= amount
	animated_sprite_2d.modulate = Color.RED
	modulator.start()
	if p_health <= 0:
		health_zero.emit()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	damage_dealt(1)
	
func _on_health_zero():
	print("You are Dead")
	character.visible = false
	area.queue_free() 
	restart.start()

func _on_restart_timer_timeout() -> void:
	Global.coins = 0
	get_tree().reload_current_scene()

func _on_modulator_timeout() -> void:
	animated_sprite_2d.modulate = Color(1, 1, 1, 1)
