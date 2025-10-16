class_name Player
extends Node

@export var movement: Movement 

func _physics_process(_delta: float) -> void:
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	if movement:
		movement.move(direction, false)
