extends Node

signal zero_hour

var MAX_MINUTES = 720.0
var START_MINUTES = MAX_MINUTES

var minutes
var timed_out_flag = false

func _process(_delta: float) -> void:
	if not timed_out_flag and not Globals.game_paused:
		set_minutes()
		check_timeout()

func set_minutes() -> void:
	minutes = CountryManager.get_highest_influence() / (CountryManager.get_total_influence() / 2.0) * MAX_MINUTES

func check_timeout() -> void:
	if minutes <= 0.0 and not timed_out_flag:
		minutes = 0.0
		zero_hour.emit()
		timed_out_flag = true
