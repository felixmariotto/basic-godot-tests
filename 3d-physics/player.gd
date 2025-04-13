extends CharacterBody3D

func _physics_process(delta: float) -> void:

	# velocity is set in game.gd according to key input,
	# it is expressed in meters/second.
	# since delta is also expressed in second in _physics_process, we can just multiply as is.
	
	var collision_result = move_and_collide( velocity * delta )
	
	if collision_result:
		
		var old_velocity = velocity
		
		velocity = velocity.slide( collision_result.get_normal() )
		
		position += velocity * delta
		
		var collider = collision_result.get_collider()
		
		if collider is RigidBody3D:
			
			var collision_point = collision_result.get_position()
			var reaction_vector = collision_result.get_collider_velocity().bounce( collision_result.get_normal() ) * 0.5 + old_velocity * 0.5
			
			print( reaction_vector )
			
			collider.apply_impulse( reaction_vector, collider.position - collision_point )
