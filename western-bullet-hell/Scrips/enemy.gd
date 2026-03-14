extends CharacterBody2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
	
#var speed = 30
#
#var enemy_velocity = Vector2.ZERO
#
#var player = get_tree().get_first_node_in_group("player")
#
#var randomnum
#
#var target
#
#enum {
	#SURROUND, ATTACK, HIT
#}
#
#var state = SURROUND
#
#func _ready():
	#var rng = RandomNumberGenerator.new()
	#rng.randomize()
	#randomnum = rng.randf()
	#target = get_circle_position(randomnum)
#
#func _physics_process(delta):
	#match state:
		#SURROUND:
			#move(target, delta)
			#
#func get_circle_position(random):
	#var kill_circle_center = player.global_position
	#var radius = 40
	#var angle = random * PI * 2
	#var x = kill_circle_center.x + cos(angle) + radius
	#var y = kill_circle_center.y + sin(angle) + radius
	#
	#return Vector2(x,y)
#
#func move(target, delta):
	#var direction = (target - global_position.normalized())
	#var desired_velocity = direction * speed
	#var steering = (desired_velocity - enemy_velocity) * delta * 2.5
	#enemy_velocity += steering
	#enemy_velocity = move_and_slide()s
