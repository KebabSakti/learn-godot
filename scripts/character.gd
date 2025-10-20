class_name Character extends Node

@export var health := 100
@export var damage := 5
@export var speed := 150.0
@export var body : PhysicsBody2D
@export var sprite : AnimatedSprite2D
@export var animation : AnimationPlayer

func process(direction : Vector2, isAttacking : bool):
	if isAttacking:
		body.velocity = Vector2.ZERO
		animation.play('attack')
		return
	
	if animation.current_animation != 'attack':
		if direction.x > 0 : sprite.scale.x = 1
		elif direction.x < 0 : sprite.scale.x = -1
			
		if direction != Vector2.ZERO:
			body.velocity = direction * speed
			animation.play('run')
		else:
			body.velocity = Vector2.ZERO
			animation.play('idle')
		
		body.move_and_slide()
		
func get_target() -> PhysicsBody2D:
	var result
	var node
	
	if is_in_group('blue'):
		node = get_tree().get_nodes_in_group('red')
	elif is_in_group('red'):
		node = get_tree().get_nodes_in_group('blue')
		
	if node.size() > 0:
		node = node.pick_random()
	
	if node:
		result = node as PhysicsBody2D
		
	return result
