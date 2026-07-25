extends Control

@export var function_name: String

func _on_button_pressed() -> void:
	Callable(Globals.PlayerCountry, function_name).call(Globals.selected_country)
