extends Control

@onready var name_node = $CountryNameTextBox
@onready var stats_node = $StatsTextBox

var current_country: Country = null

func _ready() -> void:
	
	hide()
	
	Globals.country_hover.connect(hover)
	Globals.country_unhover.connect(unhover)
	
	name_node.text = ""
	stats_node.text = "N/A\nN/A\nN/A\nN/A"

func _process(delta: float) -> void:
	if visible:
		set_stat_text()

func _input(event) -> void:
	if event is InputEventMouseMotion:
		position = event.position

func set_name_text() -> void:
	name_node.text = current_country.long_name

func set_stat_text() -> void:
	var text = ""
	text += str(snapped(current_country.influence, 0.01)) + "\n"
	text += "$" + str(snapped(current_country.money, 0.01)) + "\n"
	text += str(snapped(current_country.uranium, 0.01)) + "\n"
	text += str(snapped(current_country.nukes, 0.01))
	stats_node.text = text

func hover(country: Country) -> void:
	current_country = country
	set_name_text()
	set_stat_text()
	show()

func unhover() -> void:
	hide()
