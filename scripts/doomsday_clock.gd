extends Node

signal zero_hour

var MAX_MINUTES = 5.0
var START_MINUTES = MAX_MINUTES

var minutes
var timed_out_flag = false

func _ready() -> void:
	minutes = START_MINUTES

func _process(_delta: float) -> void:
	set_minutes()
	check_timeout()

func set_minutes() -> void:
	pass

func check_timeout() -> void:
	if minutes <= 0.0 and not timed_out_flag:
		minutes = 0.0
		zero_hour.emit()
		timed_out_flag = true
