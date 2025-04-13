extends CharacterBody2D

@export var speed := 300.0
var input_direction := Vector2()

func _physics_process(delta: float) -> void:
	
	# reset direction
	input_direction.x = 0.0
	input_direction.y = 0.0
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1.0
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1.0
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1.0
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1.0
	input_direction = input_direction.normalized()
	
	var collision_info = move_and_collide( input_direction * delta * speed )
	
	if collision_info:
		var collision_normal = collision_info.get_normal()
		move_and_collide( collision_info.get_remainder().slide( collision_normal ) )
		var collider = collision_info.get_collider()
		# here we should apply an impulse on the collider object
		if collider is RigidBody2D:
			collider.apply_impulse( collision_info.get_collider_velocity() * -0.2, collision_info.get_position() - collider.position )
