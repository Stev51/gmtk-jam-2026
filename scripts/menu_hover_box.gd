extends Control

@onready var background_node = $Background
@onready var title_node = $TitleTextBox
@onready var description_node = $DescriptionTextBox

var hovered = 0

func _ready() -> void:
	hide()

func _input(event) -> void:
	if visible and event is InputEventMouseMotion:
		position = event.position

func hover(title: String, desc: String) -> void:
	hovered += 1
	set_text(title, desc)
	set_boundaries.call_deferred()
	show()

func unhover() -> void:
	hovered -= 1
	if hovered <= 0:
		hide()

func set_text(title: String, desc: String) -> void:
	title_node.text = title
	description_node.text = desc

func set_boundaries() -> void:
	background_node.size.x = max(title_node.size.x, description_node.size.x) + 20
	background_node.size.y = title_node.size.y + description_node.size.y + 10
