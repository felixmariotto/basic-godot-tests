extends Node2D

@export var spawn_interval := 1.0

var Ball = preload("res://ball.tscn")
var timer = 0.0

func _physics_process(delta: float) -> void:
	timer += delta
	# spawn a ball
	if timer >= spawn_interval:
		timer = 0.0
		var spawn_position = $BallsPath.curve.sample( 0, randf() )
		if Ball:
			var ball = Ball.instantiate()
			ball.position = spawn_position
			add_child( ball )
