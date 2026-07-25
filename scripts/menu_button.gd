extends Control

@export var title: String
@export var description: String
@export var function_name: String

func _on_button_pressed() -> void:
	print("Button pressed!")
	#Callable(Globals.PlayerCountry, function_name).call(Globals.selected_country)

func _on_button_mouse_entered() -> void:
	MenuHoverBox.hover(title, description)

func _on_button_mouse_exited() -> void:
	MenuHoverBox.unhover()
