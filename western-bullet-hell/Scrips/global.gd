extends Node

var coins := 0
var player_speed := 300

func _process(delta: float) -> void:
	if player_speed < 300:
		await get_tree().create_timer(10.0)
		player_speed = 300
