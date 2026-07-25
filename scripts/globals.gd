extends Node

enum GameSpeed {PAUSED, NORMAL, FAST}

signal country_hover(country: Country)
signal country_unhover

signal country_click(country: Country, pos: Vector2)
signal country_unclick

var hovered_countries = 0
var clicked = false

var game_speed = GameSpeed.NORMAL
var map_hoverable = true

var PlayerCountry

func _ready() -> void:
	# Fetch the root of the active scene and check if it's already done
	var current_scene = get_tree().current_scene
	if current_scene.is_node_ready():
		_on_entire_tree_ready()
	else:
		current_scene.ready.connect(_on_entire_tree_ready)

func _on_entire_tree_ready() -> void:
	PlayerCountry = CountryManager.countries[0]

func map_hover(country: Country) -> void:
	hovered_countries += 1
	country_hover.emit(country)

func map_unhover() -> void:
	hovered_countries -= 1
	if hovered_countries <= 0:
		country_unhover.emit()

func map_click(country: Country, pos: Vector2) -> void:
	clicked = true
	country_click.emit(country, pos)

func map_unclick() -> void:
	clicked = false
	country_unclick.emit()
