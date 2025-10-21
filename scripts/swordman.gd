class_name Swordman extends Character

var isAttacking := false
var target : PhysicsBody2D

func get_target() -> PhysicsBody2D:
	var result : PhysicsBody2D
	var nodes : Array[Node]

	if is_in_group('blue'):
		nodes = get_tree().get_nodes_in_group('red')
	elif is_in_group('red'):
		nodes = get_tree().get_nodes_in_group('blue')

	if nodes.size() > 0:
		var closest := nodes[0]
		var distance = self.global_position.distance_to(closest.global_position)
		
		for i in nodes:
			var a = self.global_position.distance_to(i.global_position)
			if a < distance:
				closest = i
				distance = a
		
		result = closest

	return result
	
func _process(_delta: float) -> void:
	if not target or not is_instance_valid(target):
		target = get_target()
		
	if target:
		var direction = (target.global_position - self.global_position).normalized()
		process(direction, isAttacking)
	else:
		process(Vector2.ZERO, false)

func _on_hitbox_body_entered(_body: Node2D) -> void:
	isAttacking = true

func _on_hitbox_body_exited(_body: Node2D) -> void:
	isAttacking = false

func _on_hurtbox_body_entered(_body: Node2D) -> void:
	if (_body.health > 0):
		_body.health -= self.damage
	else:
		_body.queue_free()
		self.health += 30
		self.damage += 2
