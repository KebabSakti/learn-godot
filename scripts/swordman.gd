class_name Swordman extends Character

var isAttacking := false

func _process(delta: float) -> void:
	var direction = Vector2(Input.get_axis('left','right'), Input.get_axis('up','down')).normalized()
	process(direction, isAttacking)

func _on_hitbox_body_entered(body: Node2D) -> void:
	isAttacking = true
