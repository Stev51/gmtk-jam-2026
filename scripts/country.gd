class_name Country extends Resource

var money
var uranium
var nukes
var influence
var labs
var mines
var research_progress
var can_build_nukes
var willingness_to_fire_nukes
var signed_armistice

var delta_money
var delta_uranium
var delta_influence
var delta_research_progress
var delta_willingness_to_fire_nukes

@export var long_name: String
@export var short_name: String
@export var index: int

@export var initial_money = 0.0
@export var initial_uranium = 0.0
@export var initial_nukes = 0
@export var initial_influence = [0.0, 0.0, 0.0, 0.0, 0.0]
@export var initial_labs = 0
@export var initial_mines = 0
@export var initial_research_progress = 0.0
@export var initial_can_build_nukes = false
@export var initial_willingness_to_fire_nukes = 0.0
@export var initial_signed_armistice = false

@export var initial_delta_money = 0.0
@export var initial_delta_uranium = 0.0
@export var initial_delta_influence = [0.0, 0.0, 0.0, 0.0, 0.0]
@export var initial_delta_research_progress = 0.0
@export var initial_delta_willingness_to_fire_nukes = 0.0

func init() -> void:
	reset_resources()

func reset_resources() -> void:
	money = initial_money
	uranium = initial_uranium
	nukes = initial_nukes
	influence = initial_influence
	labs = initial_labs
	mines = initial_mines
	research_progress = initial_research_progress
	can_build_nukes = initial_can_build_nukes
	willingness_to_fire_nukes = initial_willingness_to_fire_nukes
	signed_armistice = initial_signed_armistice
	delta_money = initial_delta_money
	delta_uranium = initial_delta_uranium
	delta_influence = initial_delta_influence
	delta_research_progress = initial_delta_research_progress
	delta_willingness_to_fire_nukes = initial_delta_willingness_to_fire_nukes

#Domestic Actions

func raise_war_taxes() -> void:
	if influence[index] >= 10:
		influence[index] -= 10
		delta_money += 1

#function called for spreading positive propaganda of own country
func spread_propaganda() -> void:
	if money >= 100:
		money -= 100
		delta_influence[index] += 0.1

func build_lab() -> void:
	if money >= 1000:
		money -= 1000
		labs += 1

func build_mine() -> void:
	if money >= 10000:
		money -= 10000
		mines += 1

func establish_nuclear_capabilities() -> void:
	if research_progress > 99.9:
		can_build_nukes = true

func build_nuke() -> void:
	if money >= 1000000 && uranium > 1 && can_build_nukes == true:
		money -= 1000000
		uranium -= 1
		nukes += 1

#Only available to the player
func enforce_armistice() -> void:
	if CountryManager.all_countries_signed_armistice == true:
		DoomsdayClock.infinite_hour.emit()

#Foreign Actions

func send_gift(target) -> void:
	if money >= 10000:
		money -= 10000
		influence[target] += 20

#function called for spreading negative propaganda of target country
func spread_counter_propaganda(target) -> void:
	if money >= 100:
		money -= 100
		CountryManager.countries[target].delta_influence[target] -= 0.1

func send_diplomat(target) -> void:
	if influence[index] > 10:
		influence[index] -= 10
		delta_influence[target] += 0.1

func spy_on_technology(target) -> void:
	if money >= 10000:
		money -= 10000
		#Boost progress by half the tech gap, at least 5
		research_progress += maxf(5, (CountryManager.countries[target].research_progress - research_progress) / 2)

func sabotage_mine(target) -> void:
	if money >= 20000 && influence[target] >= 30 && CountryManager.countries[target].mines >= 1:
		money -= 20000
		influence[target] -= 30
		CountryManager.countries[target].mines -= 1

func sabotage_lab(target) -> void:
	if money >= 2000 && influence[target] >= 30 && CountryManager.countries[target].labs >= 1:
		money -= 2000
		influence[target] -= 30
		CountryManager.countries[target].labs -= 1

func steal_uranium(target) -> void:
	if money >= 30000 && influence[target] >= 30 && CountryManager.countries[target].uranium >= 0.5:
		money -= 30000
		influence[target] -= 30
		CountryManager.countries[target].uranium -= 0.5
		uranium += 0.5

func calm_fears(target):
	if influence[target] >= 20 && CountryManager.countries[target].willingness_to_use_nukes >= 20:
		influence[target] -= 20
		CountryManager.countries[target].willingness_to_use_nukes -=20

#Only available to the player
func convince_to_sign_armistice(target) -> void:
	if influence[target] >= 80 && CountryManager.countries[target].willingness_to_fire_nukes <= 10 && CountryManager.countries[target].signed_armistice == false:
		influence[target] -= 80
		CountryManager.countries[target].willingness_to_fire_nukes -=10
		CountryManager.countries[target].signed_armistice = true
