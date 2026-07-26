extends Control

@onready var name_node = $CountryNameTextBox
@onready var stats_node1 = $StatsTextBox
@onready var stats_node2 = $StatsTextBox2

func _ready() -> void:
	
	hide()
	
	Globals.country_hover.connect(hover)
	Globals.country_unhover.connect(unhover)
	
	Globals.country_click.connect(click)
	Globals.country_unclick.connect(unclick)
	
	name_node.text = ""

func _process(_delta: float) -> void:
	if visible:
		set_stat_text()

func _input(event) -> void:
	if event is InputEventMouseMotion and not Globals.clicked:
		position = event.position

func set_name_text() -> void:
	name_node.text = Globals.selected_country.long_name

func set_stat_text() -> void:
	
	stats_node1.clear()
	stats_node2.clear()
	stats_node1.text = ""
	stats_node2.text = ""
	
	stats_node1.append_text(str(snapped(Globals.PlayerCountry.influence[Globals.selected_country.index], 0.01)) + '\n')
	stats_node1.append_text(str(snapped(Globals.selected_country.money, 0.01)) + '\n')
	stats_node1.append_text(str(snapped(Globals.selected_country.uranium, 0.01)) + '\n')
	stats_node1.append_text(str(snapped(Globals.selected_country.nukes, 0.01)) + '\n')
	stats_node2.append_text(str(snapped(Globals.selected_country.research_progress, 0.01)) + '\n')
	stats_node2.append_text(str(snapped(Globals.selected_country.labs, 0.01)) + '\n')
	stats_node2.append_text(str(snapped(Globals.selected_country.mines, 0.01)) + '\n')
	stats_node2.append_text(str(snapped(Globals.selected_country.willingness_to_fire_nukes, 0.01)) + '\n')

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
