extends Node2D

var blueswordman := preload("res://scenes/blueswordman.tscn")
var redswordman := preload("res://scenes/redswordman.tscn")
var limit := 3
var counter := 0

func _process(_delta: float) -> void:
	var blue_team = get_tree().get_nodes_in_group('blue')
	var red_team = get_tree().get_nodes_in_group('red')
	
	if blue_team.size() < limit:
		for i in range(limit - blue_team.size()):
			spawn(blueswordman.instantiate(), get_random_position())
	elif red_team.size() < limit:
		for i in range(limit - red_team.size()):
			spawn(redswordman.instantiate(), get_random_position())

func spawn(node : Node, vector : Vector2):
	counter += 1
	node.global_position = vector
	node.name_label.text = 'Mr. ' + str(counter)
	add_child(node)
	
func get_random_position() -> Vector2:
	var spawn_area := Rect2(Vector2(300, 200), Vector2(1200, 200))
	
	return Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	)
