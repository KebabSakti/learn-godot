class_name Movement
extends Node

@export var speed : float = 150.0
@export var body : CharacterBody2D
@export var animation : AnimationPlayer
@export var sprite : Node2D

func move(direction : Vector2, attacking : bool):
	if direction.x > 0:
		sprite.scale.x = 1
	elif direction.x < 0:
		sprite.scale.x = -1
		
	if direction and !attacking:
		body.velocity = direction * speed
		animation.play("run")
	else:
		body.velocity = body.velocity.move_toward(Vector2.ZERO, speed)
		if attacking:
			animation.play("attack")
		else:
			if !animation.is_playing():
				animation.play('idle')

	body.move_and_slide()
