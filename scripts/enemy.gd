class_name Enemy
extends Node

@export var movement: Movement
@export var timer: Timer

var player: CharacterBody2D
var enemy: CharacterBody2D
var direction: Vector2 = Vector2.ZERO
var chasing := true
var attacking := false

func _ready() -> void:
	enemy = get_parent()
	player = get_tree().current_scene.get_node("Warrior")
	var players = get_tree().get_nodes_in_group('blue')
	print(players)

func _physics_process(_delta: float) -> void:
	direction = (player.position - enemy.position).normalized() if chasing else Vector2.ZERO
	movement.move(direction, attacking)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	chasing = false
	attacking = true
	timer.stop()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	attacking = false
	timer.start()

func _on_timer_timeout() -> void:
	chasing = true
