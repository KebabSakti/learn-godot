class_name Swordman extends Character

@onready var hitbox: Area2D = $AnimatedSprite2D/Hitbox

var isAttacking := false
var target : Node2D
var locked : Node2D

func get_target() -> PhysicsBody2D:
	var result : Node2D
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
		if not locked:
			target = get_target()
		else:
			target = locked
		
	if target:
		var direction = (target.global_position - self.global_position).normalized()
		process(direction, isAttacking)
	else:
		process(Vector2.ZERO, false)
		
	var bodies = hitbox.get_overlapping_bodies()
	if bodies.size() > 0:
		isAttacking = true
		locked = bodies[0]
	else:
		isAttacking = false

func _on_hurtbox_body_entered(_body: Node2D) -> void:
	_body.health -= self.damage
	
	if _body.health <= 0:
		print(self.name_label.text + ' killed ' + _body.name_label.text)
		_body.queue_free()
		self.health += 30
		locked = null
