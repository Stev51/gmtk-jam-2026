extends Control

var MAX_DISPLAY_TIME = 60.0

@onready var hand_sprite_node = $Hand

func _process(delta: float) -> void:
	hand_sprite_node.rotation_degrees = (DoomsdayClock.time_left / MAX_DISPLAY_TIME) * -360.0
