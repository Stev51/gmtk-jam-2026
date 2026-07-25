extends Control

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
	show()
	print(hovered)

func unhover() -> void:
	hovered -= 1
	if hovered <= 0:
		hide()
	print(hovered)

func set_text(title: String, desc: String) -> void:
	title_node.text = title
	description_node.text = desc
