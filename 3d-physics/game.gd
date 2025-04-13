extends Node3D

@export var player_speed = 3.0 # meters/second
var target_velocity = Vector3()

func _physics_process(delta: float) -> void:
	
	target_velocity = Vector3()
	
	if Input.is_action_pressed("ui_left"):
		target_velocity.x -= 1.0
	
	if Input.is_action_pressed("ui_right"):
		target_velocity.x += 1.0
	
	if Input.is_action_pressed("ui_up"):
		target_velocity.z -= 1.0
	
	if Input.is_action_pressed("ui_down"):
		target_velocity.z += 1.0
	
	target_velocity = target_velocity.normalized() * player_speed
	
	# meters/second
	var gravity = ProjectSettings.get_setting("physics/3d/default_gravity_vector") * ProjectSettings.get_setting("physics/3d/default_gravity")
	
	target_velocity += gravity
	
	# just some easing, nothing important
	$Player.velocity += ( target_velocity - $Player.velocity ) * 0.1
