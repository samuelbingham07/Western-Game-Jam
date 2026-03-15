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
	var nwidth = randi_range(1, width)
	var nheight = randi_range(1, height)
	var spawned = spawnable_entities.pick_random()
	var spawn = spawned.instantiate()

	if entities < max_entities:
		spawn.global_position = Vector2(nwidth, nheight)
		add_child(spawn)
		timer.wait_time = randi_range(1, 2)
		entities += 1

		# Pass the player reference to enemies after adding to scene
		if spawn.has_method("set_player"):
			var player = get_tree().get_first_node_in_group("player")
			spawn.set_player(player)

	spawn.tree_exited.connect(remove_entities)
	
