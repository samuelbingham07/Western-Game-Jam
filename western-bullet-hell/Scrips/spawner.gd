extends Node2D

var width := 1152
var height := 648
var entities := 0
var spawnable_entities := [
	preload("res://Scenes/coin.tscn"),
	preload("res://Scenes/enemy.tscn"),
]
var boss_scene = preload("res://Scenes/boss.tscn")

@export var max_entities := 6
@export var boss_timer := 120
@onready var timer = $Timer

var elapsed_time := 0.0
var base_wait_min := 1.0
var base_wait_max := 2.0
var boss_spawned := false
var boss_phase := false

func _ready() -> void:
	timer.wait_time = randi_range(1, 2)

func _process(delta: float) -> void:
	if boss_phase:
		if not boss_spawned and entities == 0:
			spawn_boss()
		return

	elapsed_time += delta

	if elapsed_time >= boss_timer:
		boss_phase = true
		max_entities = 0

func spawn_boss() -> void:
	if boss_spawned:
		return
	boss_spawned = true
	var boss = boss_scene.instantiate()
	boss.global_position = Vector2(-50, height / 2)
	add_child(boss)

func remove_entities():
	if entities > 0:
		entities -= 1

func _on_timer_timeout() -> void:
	if boss_phase:
		return

	var spawned = spawnable_entities.pick_random()
	var spawn = spawned.instantiate()

	if entities < max_entities:
		if spawned == spawnable_entities[0]:  # coin
			var margin_x = int(width * 0.125)
			var margin_y = int(height * 0.125)
			spawn.global_position = Vector2(
				randi_range(margin_x, width - margin_x),
				randi_range(margin_y, height - margin_y)
			)
		else:  # enemy
			if randi_range(0, 1) == 0:
				spawn.global_position = Vector2(-50, randi_range(130, 518))
			else:
				spawn.global_position = Vector2(width + 50, randi_range(130, 518))

		add_child(spawn)
		entities += 1

	var t = clamp(elapsed_time / boss_timer, 0.0, 1.0)
	var wait_min = lerp(base_wait_min, base_wait_min * 0.5, t)
	var wait_max = lerp(base_wait_max, base_wait_max * 0.5, t)
	timer.wait_time = randf_range(wait_min, wait_max)

	spawn.tree_exited.connect(remove_entities)
