extends Node2D

var config := ConfigFile.new()
var config_path = "user://game_config.cfg"
var scene_data_path = "user://scene_state.dat"

var timer = 0.0
var interval = 1.0 # seconds

var Sprite = preload("res://sprite.tscn")

func _ready() -> void:
	
	# load the config file, and if it doesn't exist, create it with initial value.
	
	var err = config.load( config_path )
	
	if err != OK:
		
		config.set_value( "time", "total_play_time", timer )
	
	# load the scene state file and add sprites to the recorded positions
	
	var file = FileAccess.open( scene_data_path, FileAccess.READ )
	
	if file:
		
		var sprite_positions = file.get_var()
		
		for sprite_position in sprite_positions:
			
			add_sprite( sprite_position )


func _process(delta: float) -> void:
	
	# increment the timer, and compute the total play time, including the recorded time from previous sessions
	
	timer += delta
	
	var previous_time = config.get_value( "time", "total_play_time" )
	
	var total_play_time = previous_time + timer
	
	# disaplay the time in a label in the scene
	
	$Timer.text = "Game time: " + String.num( total_play_time, 1 ) + "s"
	
	# every second, record the total play time and the current state of the scene
	
	if timer >= interval:
		
		timer = 0.0
		
		config.set_value( "time", "total_play_time", total_play_time )
		
		config.save( config_path )
		
		record_scene_state()


func _unhandled_input(event: InputEvent) -> void:
	
	# call function when the player clicks in the viewport with their mouse
	
	if event is InputEventMouseButton and event.pressed :
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			
			add_sprite( event.position )
		
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			
			remove_sprite( event.position )


# add a sprite in the 2D scene at the passed viewport position
func add_sprite( position: Vector2 ):
	
	var sprite = Sprite.instantiate()
	
	sprite.position = position
	
	add_child( sprite )


# remove every sprite located on the past viewport position
func remove_sprite( position: Vector2 ):
	
	for child in get_children():
		
		if child is Sprite2D:
		
			var local_point = child.to_local( position )
			
			if child.get_rect().has_point( local_point ):
				
				child.queue_free()


# record the sprites in a save file
func record_scene_state():
	
	var file = FileAccess.open( scene_data_path, FileAccess.WRITE )
	
	var positions = []
	
	for child in get_children():
		
		if child is Sprite2D:
			
			positions.append( child.position )
	
	file.store_var( positions )
	
	file.close()
