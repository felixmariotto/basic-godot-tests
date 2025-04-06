extends Camera2D

@export var pos_offset := Vector2( 500.0, 500.0 )
@export var rotation_radius := 200.0
@export_range(0.0, PI * 2.0) var radial_offset := 0.0

func _process(delta: float) -> void:
	position.x = rotation_radius * sin( Time.get_ticks_msec() / 1000.0 + radial_offset ) + pos_offset.x
	position.y = rotation_radius * cos( Time.get_ticks_msec() / 1000.0 + radial_offset ) + pos_offset.y
