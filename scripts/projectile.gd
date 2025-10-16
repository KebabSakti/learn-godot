class_name Projectile
extends Node

@export var speed : float = 1
@export var body : Area2D
var target : CharacterBody2D

func _ready() -> void:
	var main = get_tree().current_scene
	target = main.get_node('Target')
	body.look_at(target.position)

func _physics_process(delta: float) -> void:
	if body:
		body.position += target.position * speed * delta

func _on_arrow_body_entered(_body: Node2D) -> void:
	body.queue_free()
