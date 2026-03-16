extends Node2D

var width := 1152
var height := 648
var entities := 0
var barrels := preload("res://Scenes/barrel.tscn")

@export var max_entities := 6
@onready var timer = $Timer


func _ready() -> void:
	timer.wait_time = randi_range(1, 20)

func remove_entities():
	if entities > 0:
		entities -= 1

func _on_timer_timeout() -> void:

	var spawn = barrels.instantiate()

	if entities < max_entities:
		var margin_x = int(width * 0.125)
		var margin_y = int(height * 0.2)
		spawn.global_position = Vector2(
			randi_range(margin_x, width - margin_x),
			randi_range(margin_y, height - margin_y)
		)
		add_child(spawn)
		entities += 1
		timer.wait_time = randi_range(1, 20)

	spawn.tree_exited.connect(remove_entities)
