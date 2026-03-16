extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var deletion: Timer = $Deletion

@onready var powerup_label = get_tree().get_root().find_child("RichTextLabel", true, false)

var bad_things: Array[Callable] = [speed_down, max_bullet_down, speed_up, do_damage]
var powerup_messages = {
	"speed_down": "You are now slow!",
	"speed_up": "You are fast!",
	"do_damage": "Your health has changed!",
	"max_bullet_down": "You have only two bullets!"
}

func _ready() -> void:
	pass

func speed_down():
	Global.player_speed = 100
	show_message(powerup_messages["speed_down"])

func max_bullet_down():
	Global.max_bullets = 2
	show_message(powerup_messages["max_bullet_down"])

func speed_up():
	Global.player_speed = 600
	show_message(powerup_messages["speed_up"])

func do_damage():
	if Global.p_health > 5:
		Global.p_health -= 3 
	else:
		Global.p_health += 1
	show_message(powerup_messages["do_damage"])

func show_message(text: String):
	if powerup_label:
		powerup_label.text = text
		powerup_label.visible = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	animated_sprite_2d.play("opening")
	area_2d.queue_free()
	deletion.start()
	var baddy = bad_things.pick_random()
	baddy.call()

func _on_deletion_timeout() -> void:
	queue_free()
