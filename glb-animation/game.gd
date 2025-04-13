extends Node3D

@export var speed = 3.0

var direction = Vector2()
var boxman
var boxman_anim_player

func _ready() -> void:
	
	boxman = $boxman
	boxman_anim_player = $boxman/AnimationPlayer
#

func _process(delta: float) -> void:
	
	# set direction vector according to key input
	
	direction.x = 0.0
	direction.y = 0.0
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1.0
		
	if Input.is_action_pressed("ui_right"):
		direction.x += 1.0
		
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1.0
		
	if Input.is_action_pressed("ui_down"):
		direction.y += 1.0
	
	direction = direction.normalized()
	
	# update boxman animation
	
	if boxman_anim_player:
		
		if direction.length() > 0.0:
			
			boxman_anim_player.play("run")
			
		else:
			
			boxman_anim_player.play("idle")
	
	# update boxman position and rotation
	
	if boxman :
		
		boxman.position.x += direction.x * delta * speed
		boxman.position.z += direction.y * delta * speed
		
		if direction.length() > 0.0:
			
			boxman.rotation.y = -1.0 * direction.angle() + PI * 0.5
