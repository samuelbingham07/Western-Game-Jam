extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var deletion: Timer = $Deletion


var bad_things: Array[Callable] = [ speed_down, 
max_bullet_down,
speed_up,
do_damage,
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func speed_down():
	Global.player_speed = 100

func max_bullet_down():
	Global.max_bullets = 2
	
func speed_up():
	Global.player_speed = 600
	
func do_damage():
	if Global.p_health > 5:
		Global.p_health - 3
	else:
		Global.p_health + 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	animated_sprite_2d.play("opening")
	area_2d.queue_free()
	deletion.start()
	var baddy = bad_things.pick_random()
	baddy.call()
	#if baddy == speed_down:
		#effects.rich_text_label.text = "You are now slow!"
	#if baddy == speed_up:
		#effects.rich_text_label.text = "You are fast!"
	#if baddy == do_damage:
		#effects.rich_text_label.text = "Your health has changed!"
	#if baddy == max_bullet_down:
		#effects.rich_text_label.text = "You have only two bullets!"

func _on_deletion_timeout() -> void:
	queue_free()
