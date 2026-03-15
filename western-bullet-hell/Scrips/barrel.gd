extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var deletion: Timer = $Deletion

var bad_things: Array[Callable] = [ speed_down, max_bullet_down]


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

func _on_area_2d_area_entered(area: Area2D) -> void:
	animated_sprite_2d.play("opening")
	area_2d.queue_free()
	deletion.start()
	bad_things.pick_random().call()

func _on_deletion_timeout() -> void:
	queue_free()
