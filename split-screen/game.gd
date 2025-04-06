extends Node2D

func _ready() -> void:
	$SubViewportContainer1/SubViewport.world_2d = $CommonViewport.world_2d
	$SubViewportContainer2/SubViewport.world_2d = $CommonViewport.world_2d
