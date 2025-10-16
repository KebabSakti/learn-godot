class_name Enemy
extends Node

@export var movement : Movement
@export var timer : Timer

var chase : bool = true
var attacking : bool
var direction : Vector2
var enemy : CharacterBody2D
var player : CharacterBody2D

func _ready() -> void:
	var main = get_tree().current_scene
	player = main.get_node('Warrior')
	enemy = get_parent()

func _physics_process(_delta: float) -> void:
	if chase:
		direction = (player.position - enemy.position).normalized()
	else:
		direction = Vector2.ZERO
	
	if movement:
		movement.move(direction, attacking)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	chase = false
	attacking = true
	timer.stop()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	attacking = false
	timer.start()

func _on_timer_timeout() -> void:
	chase = true
