extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed :
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			
			add_sprite( event.position )
		
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			
			remove_sprite( event.position )

#

func add_sprite( position: Vector2 ):
	
	print( 'add sprite at ', position )

func remove_sprite( position: Vector2 ):
	
	print( 'remove sprites at ', position )
