extends Node

enum GameSpeed {PAUSED, NORMAL, FAST}

signal country_hover(country: Country)
signal country_unhover

var hovered_countries = 0

var game_speed = GameSpeed.NORMAL
var map_hoverable = true

func map_hover(country: Country) -> void:
	hovered_countries += 1
	country_hover.emit(country)

func map_unhover() -> void:
	hovered_countries -= 1
	if hovered_countries <= 0:
		country_unhover.emit()
