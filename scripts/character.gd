class_name Character extends Node

@export var health := 100
@export var damage := 5
@export var speed := 150.0
@export var body : PhysicsBody2D
@export var sprite : AnimatedSprite2D
@export var animation : AnimationPlayer
@export var health_bar : ProgressBar
@export var label : Label
@export var effect : AnimationPlayer
@export var name_label : Label

var blue := 0
var red := 0

func _ready() -> void:
	#print(self.name, " animation id:", animation.get_instance_id())
	#print(self.name, " effect id:", effect.get_instance_id())
	pass

func process(direction : Vector2, isAttacking : bool):
	if label:
		label.text = str(health)
		
	health_bar.set_value_no_signal(health)
	
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
