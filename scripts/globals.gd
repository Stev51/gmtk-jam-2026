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
