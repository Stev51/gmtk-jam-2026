extends Node

var timed_out_flag = false

var NUKES_TO_INFLUENCE = 0.05
var INFLUENCE_WILLINGNESS_DECREASE = 10.0
var INFLUENCE_TO_MONEY = 1.0
var MONEY_TO_URANIUM = 132000.0
var MONEY_TO_NUKES = 500.0
var URANIUM_TO_NUKES = 0.05

var DELTA_MOD = 0.1

@export var countries: Array[Country]

func _ready() -> void:
	
	for country in countries:
		country.init()
	
	DoomsdayClock.zero_hour.connect(zero_hour)

func _process(delta: float) -> void:
	if not timed_out_flag and Globals.game_speed != Globals.GameSpeed.PAUSED:
		
		delta *= DELTA_MOD
		if Globals.game_speed == Globals.GameSpeed.FAST:
			delta *= 2
		
		for country in countries:
			process_country(country, delta)

func process_country(country: Country, delta: float) -> void:
	#Five passive stats: money, uranium, research, willingness, influence
	#delta uranium and delta progress should never be negative. Money can go negative lol. Willingness and influence are bounded at zero.
	country.money += country.delta_money * delta
	country.uranium += country.delta_uranium * delta
	country.research_progress += country.delta_research_progress * delta
	country.willingness_to_fire_nukes += country.delta_willingness_to_fire_nukes * delta
	if country.willingness_to_fire_nukes < 0.0:
		country.willingness_to_fire_nukes = 0.0
	for country_b in countries:
		country.influence[country_b.index] += country.delta_influence[country_b.index]
		if country.influence[country_b.index] < 0.0:
			country.influence[country_b.index] = 0.0
	#Add math to calculate delta for willingness

#func get_total_influence() -> float:
	#var count = 0.0
	#for country in countries:
		#count += country.influence
	#return count

#func get_highest_influence() -> float:
	#var highest = 0.0
	#for country in countries:
		#if country.influence > highest:
			#highest = country.influence
	#return highest

# All of this process is just for demonstration
#func process_country(country: Country, total_influence: float, delta: float) -> void:
	#
	#country.influence += country.nukes * NUKES_TO_INFLUENCE * delta
	#country.influence -= ((total_influence - country.influence) / total_influence ) * INFLUENCE_WILLINGNESS_DECREASE * delta
	#if country.influence < 0.0:
		#country.influence = 0.0
	#
	#country.money += country.influence * INFLUENCE_TO_MONEY * delta
	#
	#if country.uranium >= URANIUM_TO_NUKES or country.money >= MONEY_TO_NUKES:
		#
		#while country.uranium >= URANIUM_TO_NUKES and country.money >= MONEY_TO_NUKES:
			#country.nukes += 1.0
			#country.uranium -= URANIUM_TO_NUKES
			#country.money -= MONEY_TO_NUKES
	#
	#else:
		#
		#while country.money >= MONEY_TO_URANIUM:
			#country.uranium += 1.0
			#country.money -= MONEY_TO_URANIUM

func zero_hour() -> void:
	timed_out_flag = true
