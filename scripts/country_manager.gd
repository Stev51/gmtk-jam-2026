extends Node

var timed_out_flag = false

# TEMP VARIABLES FOR DEMONSTRATION PURPOSES #
var NUKES_TO_INFLUENCE = 2.0
var INFLUENCE_SCARE_DECREASE = 1.0
var INFLUENCE_TO_MONEY = 1.0
var MONEY_TO_URANIUM = 250.0
var MONEY_TO_NUKES = 500.0
var URANIUM_TO_NUKES = 1.0
# ----------------------------------------- #

@export var countries: Array[Country]

func _ready() -> void:
	
	for country in countries:
		country.init()
	
	DoomsdayClock.zero_hour.connect(zero_hour)

func _process(delta: float) -> void:
	if not timed_out_flag and Globals.game_speed != Globals.GameSpeed.PAUSED:
		
		if Globals.game_speed == Globals.GameSpeed.FAST:
			delta *= 2
		
		for country in countries:
			process_country(country, get_total_influence(), delta)

func get_total_influence() -> float:
	var count = 0.0
	for country in countries:
		count += country.influence
	return count

func get_highest_influence() -> float:
	var highest = 0.0
	for country in countries:
		if country.influence > highest:
			highest = country.influence
	return highest

# All of this process is just for demonstration
func process_country(country: Country, total_influence: float, delta: float) -> void:
	
	country.influence += country.nukes * NUKES_TO_INFLUENCE * delta
	country.influence -= ((total_influence - country.influence) / total_influence ) * INFLUENCE_SCARE_DECREASE * delta
	
	country.money += country.influence * INFLUENCE_TO_MONEY * delta
	
	while country.uranium >= URANIUM_TO_NUKES and country.money >= MONEY_TO_NUKES:
		country.nukes += 1.0
		country.uranium -= URANIUM_TO_NUKES
		country.money -= MONEY_TO_NUKES
	
	while country.money >= MONEY_TO_URANIUM:
		country.uranium += 1.0
		country.money -= MONEY_TO_URANIUM

func zero_hour() -> void:
	timed_out_flag = true
