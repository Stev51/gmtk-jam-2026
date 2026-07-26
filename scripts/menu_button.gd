@tool
extends Control

@export var title: String
@export var description: String
@export var icon: Texture2D
@export var function_name: String

@onready var icon_node = $Icon

func _ready() -> void:
	set_icon()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		set_icon()

func set_icon() -> void:
	if icon != null:
		icon_node.texture = icon

func _on_button_pressed() -> void:
	print("Button pressed!")
	#Callable(Globals.PlayerCountry, function_name).call(Globals.selected_country)

func _on_button_mouse_entered() -> void:
	MenuHoverBox.hover(title, description)

func _on_button_mouse_exited() -> void:
	MenuHoverBox.unhover()
