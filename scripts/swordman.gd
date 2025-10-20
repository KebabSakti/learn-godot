class_name Swordman extends Character

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2(Input.get_axis('left','right'), Input.get_axis('up','down')).normalized()
	body.velocity = direction * speed
	body.move_and_slide()
	pass

func _on_hitbox_body_entered(body: Node2D) -> void:
	pass
