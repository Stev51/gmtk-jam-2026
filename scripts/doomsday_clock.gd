extends Timer

func pause() -> void:
	set_paused(true)

func resume() -> void:
	set_paused(false)

func add_time(seconds: float) -> void:
	var carryover = get_time_left()
	start(seconds + carryover)

func subtract_time(seconds: float) -> void:
	add_time(-seconds)
