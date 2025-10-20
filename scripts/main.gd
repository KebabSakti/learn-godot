extends Node2D

var blueswordman := preload("res://scenes/blueswordman.tscn")
var redswordman := preload("res://scenes/redswordman.tscn")

func _ready() -> void:
	start()
		
func _process(_delta: float) -> void:
	var blue_team = get_tree().get_nodes_in_group('blue')
	var red_team = get_tree().get_nodes_in_group('red')
	
	if blue_team.size() != 5:
		for i in range(5 - blue_team.size()):
			spawn(blueswordman.instantiate(), Vector2(300, 100 + i * 100))
	elif red_team.size() != 5:
		for i in range(5 - red_team.size()):
			spawn(redswordman.instantiate(), Vector2(1200, 100 + i * 100))
			
	if blue_team.size() == 0 or red_team.size() == 0:
		start()
		
func start():
	for i in range(5):
		spawn(blueswordman.instantiate(), Vector2(300, 100 + i * 100))
		spawn(redswordman.instantiate(), Vector2(1200, 100 + i * 100))

func spawn(node : Node, vector : Vector2):
	node.global_position = vector
	add_child(node)
