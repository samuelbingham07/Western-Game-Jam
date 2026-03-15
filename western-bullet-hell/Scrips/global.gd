extends Node

var coins := 0
var player_speed := 300
var available_bullets = 0

func _process(delta: float) -> void:
	if player_speed < 300:
		await get_tree().create_timer(10.0).timeout
		player_speed = 300
