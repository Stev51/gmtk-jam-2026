extends Control

@onready var name_node = $CountryNameTextBox
@onready var stats_node = $StatsTextBox

func _ready() -> void:
	
	hide()
	
	Globals.country_hover.connect(hover)
	Globals.country_unhover.connect(unhover)
	
	Globals.country_click.connect(click)
	Globals.country_unclick.connect(unclick)
	
	name_node.text = ""
	stats_node.text = "N/A\nN/A\nN/A\nN/A"

func _process(_delta: float) -> void:
	if visible:
		set_stat_text()

func _input(event) -> void:
	if event is InputEventMouseMotion and not Globals.clicked:
		position = event.position

func set_name_text() -> void:
	name_node.text = Globals.selected_country.long_name

func set_stat_text() -> void:
	var text = ""
	text += str(snapped(Globals.selected_country.influence, 0.01)) + "\n"
	text += "$" + str(snapped(Globals.selected_country.money, 0.01)) + "\n"
	text += str(snapped(Globals.selected_country.uranium, 0.01)) + "\n"
	text += str(snapped(Globals.selected_country.nukes, 0.01))
	stats_node.text = text

func click(pos: Vector2) -> void:
	set_name_text()
	set_stat_text()
	position = pos
	show()

func unclick() -> void:
	hide()

func hover() -> void:
	if not Globals.clicked:
		set_name_text()
		set_stat_text()
		show()

func unhover() -> void:
	if not Globals.clicked:
		hide()
