class_name Swordman extends Character

@onready var health_bar: ProgressBar = $ProgressBar

var isAttacking := false
var target : PhysicsBody2D

func _process(_delta: float) -> void:
	if health_bar:
		health_bar.set_value_no_signal(body.health)
	
	if not target or not is_instance_valid(target):
		target = get_target()
		
	if target:
		var direction = (target.global_position - body.global_position).normalized()
		process(direction, isAttacking)
	else:
		process(Vector2.ZERO, false)

func _on_hitbox_body_entered(_body: Node2D) -> void:
	isAttacking = true

func _on_hitbox_body_exited(_body: Node2D) -> void:
	isAttacking = false

func _on_hurtbox_body_entered(_body: Node2D) -> void:
	if (target.health > 0):
		target.health -= body.damage
	else:
		#print(target.name + " killed by " + body.name)
		target.queue_free()
