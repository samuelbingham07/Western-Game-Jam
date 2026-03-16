extends Node


var coins := 0
var player_speed := 300
var max_bullets = 6
var p_health := 10

func _process(delta: float) -> void:
	if player_speed != 300:
		await get_tree().create_timer(10.0).timeout
		player_speed = 300
		
	if max_bullets < 6:
		await get_tree().create_timer(20.0).timeout
		max_bullets = 6
