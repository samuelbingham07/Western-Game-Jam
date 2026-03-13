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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = randi_range(1, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	spawn.tree_exited.connect(remove_entities)
	
# hi hi hi
