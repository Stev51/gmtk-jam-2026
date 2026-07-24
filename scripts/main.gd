extends Node2D

func _input(event):
	if event.is_action_pressed("pause"):
		Globals.game_speed = Globals.GameSpeed.PAUSED
	elif event.is_action_pressed("x1_speed"):
		Globals.game_speed = Globals.GameSpeed.NORMAL
	elif event.is_action_pressed("x2_speed"):
		Globals.game_speed = Globals.GameSpeed.FAST
