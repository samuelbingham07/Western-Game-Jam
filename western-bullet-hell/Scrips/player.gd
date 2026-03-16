extends CharacterBody2D

var screen_size
@onready var c_label = $Coins
@onready var h_label = $Health
@onready var area = $Area2D
@onready var character = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: Node2D = $Gun
@onready var modulator: Timer = $Modulator
@onready var death_screen = $CanvasLayer
@onready var death_label = $CanvasLayer/Label
@onready var sub_label = $CanvasLayer/Label2  # ✅ Added
@onready var retry_button = $CanvasLayer/Button

const ACCEL := 10.0
const WRAPPING := 40
signal health_zero

func _ready() -> void:
	screen_size = get_viewport_rect().size
	health_zero.connect(_on_health_zero)
	animated_sprite_2d.play("walk_down")
	death_screen.visible = false

func _process(delta: float) -> void:
	var playerInput = player_movement()
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

	clamp_to_borders()
	coin_label()
	health_label()

func player_movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	return direction

func clamp_to_borders():
	position.x = clamp(position.x, 50, screen_size.x - 50)
	position.y = clamp(position.y, 100, screen_size.y - 125)

func coin_label():
	c_label.text = "Coins: " + str(Global.coins)

func health_label():
	h_label.text = "Health: " + str(Global.p_health)

func damage_dealt(amount):
	Global.p_health -= amount
	animated_sprite_2d.modulate = Color.RED
	modulator.start()
	if Global.p_health <= 0:
		health_zero.emit()

func _on_area_2d_area_entered(area: Area2D) -> void:
	damage_dealt(1)

func _on_health_zero():
	character.visible = false
	area.queue_free()
	death_label.text = "You Died!"
	sub_label.text = "Better luck next time..."  # ✅ Death message
	retry_button.text = "Retry"
	death_screen.visible = true

func show_win_screen():
	character.visible = false
	death_label.text = "You Win! 🎉"
	sub_label.text = "Congratulations!"  # ✅ Win message
	retry_button.text = "Play Again"
	death_screen.visible = true

func _on_button_pressed() -> void:
	Global.coins = 0
	Global.p_health = 10
	get_tree().reload_current_scene()

func _on_modulator_timeout() -> void:
	animated_sprite_2d.modulate = Color(1, 1, 1, 1)
