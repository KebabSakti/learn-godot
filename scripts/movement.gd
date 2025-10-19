class_name Movement
extends Node

@export var speed: float = 150.0
@export var body: CharacterBody2D
@export var animation: AnimationPlayer
@export var sprite: Node2D

var animation_locked: bool = false

func move(direction: Vector2, attacking: bool) -> void:
	# If currently locked by attack animation, skip movement updates
	if animation_locked:
		# Check if the animation has finished
		if not animation.is_playing():
			animation_locked = false
		else:
			# Still playing attack, only allow sliding
			body.move_and_slide()
			return

	# Start attack animation and lock until finished
	if attacking:
		animation_locked = true
		animation.play("attack")
		body.velocity = Vector2.ZERO
		body.move_and_slide()
		return

	# Flip sprite based on movement direction
	if direction.x > 0:
		sprite.scale.x = 1
	elif direction.x < 0:
		sprite.scale.x = -1

	# Movement logic
	if direction != Vector2.ZERO:
		body.velocity = direction * speed
		if animation.current_animation != "run":
			animation.play("run")
	else:
		body.velocity = body.velocity.move_toward(Vector2.ZERO, speed)
		if animation.current_animation != "idle":
			animation.play("idle")

	body.move_and_slide()
