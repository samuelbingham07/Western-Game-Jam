extends Node2D

var width := 1152
var height := 648
var entities := 0
var spawnable_entities := [
	preload("res://Scenes/coin.tscn"),
	preload("res://Scenes/enemy.tscn"),
]
@export var max_entities := 6
@onready var timer = $Timer

func _ready() -> void:
	timer.wait_time = randi_range(1, 2)

func _process(delta: float) -> void:
	print(entities)

func remove_entities():
	if entities > 0:
		entities -= 1

func _on_timer_timeout() -> void:
	var spawned = spawnable_entities.pick_random()
	var spawn = spawned.instantiate()

	if entities < max_entities:
		if randi_range(0, 1) == 0:
			spawn.global_position = Vector2(-50, randi_range(130, 518))  # left
		else:
			spawn.global_position = Vector2(width + 50, randi_range(130, 518))  # right

		add_child(spawn)
		timer.wait_time = randi_range(1, 2)
		entities += 1

	spawn.tree_exited.connect(remove_entities)
