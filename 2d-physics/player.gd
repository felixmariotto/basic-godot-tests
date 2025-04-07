extends CharacterBody2D

@export var speed := 300.0
var direction := Vector2()

func _physics_process(delta: float) -> void:
	
	# reset direction
	direction.x = 0.0
	direction.y = 0.0
	if Input.is_action_pressed("ui_down"):
		direction.y += 1.0
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1.0
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1.0
	if Input.is_action_pressed("ui_right"):
		direction.x += 1.0
	direction = direction.normalized()
	
	var collision_info = move_and_collide( direction * delta * speed )
	
	if collision_info:
		move_and_collide( collision_info.get_remainder().slide( collision_info.get_normal() ) )
		var collider = collision_info.get_collider()
		# here we should apply an impulse on the collider object
		print( collider )
