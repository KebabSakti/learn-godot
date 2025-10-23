extends Node2D

var blueswordman := preload("res://scenes/blueswordman.tscn")
var redswordman := preload("res://scenes/redswordman.tscn")
var limit := 4

func _ready() -> void:
	#var boss = redswordman.instantiate()
	#boss.health = 200
	#boss.damage = 28
	#spawn(boss, Vector2(1200, 200))
	pass

func _process(_delta: float) -> void:
	var blue_team = get_tree().get_nodes_in_group('blue')
	var red_team = get_tree().get_nodes_in_group('red')
	
	if blue_team.size() < limit:
		for i in range(limit - blue_team.size()):
			spawn(blueswordman.instantiate(), Vector2(300, 100 + i * 100))
	elif red_team.size() < limit:
		for i in range(limit - red_team.size()):
			spawn(redswordman.instantiate(), Vector2(1200, 100 + i * 100))
			
	#if red_team.size() == 0:
		#get_tree().reload_current_scene()

func spawn(node : Node, vector : Vector2):
	node.global_position = vector
	add_child(node)
