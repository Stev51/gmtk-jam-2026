extends Control

func _ready() -> void:
	
	hide()
	
	Globals.country_click.connect(click)
	Globals.country_unclick.connect(unclick)

func _input(event) -> void:
	if event is InputEventMouseMotion and not Globals.clicked:
		position = event.position

func click(pos: Vector2) -> void:
	position = pos
	show()

func unclick() -> void:
	hide()
