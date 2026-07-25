class_name Country extends Resource

var money
var uranium
var nukes
var influence
var labs
var mines
var research_progress
var willingness_to_fire_nukes
var signed_armistice

var delta_money
var delta_uranium
var delta_influence
var delta_research_progress
var delta_willingness_to_fire_nukes

@export var long_name = ""
@export var short_name = ""

@export var initial_money = 0.0
@export var initial_uranium = 0.0
@export var initial_nukes = 0.0
@export var initial_influence = [0.0, 0.0, 0.0, 0.0, 0.0]
@export var initial_labs = 0
@export var initial_mines = 0
@export var initial_research_progress = 0.0
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
	willingness_to_fire_nukes = initial_willingness_to_fire_nukes
	signed_armistice = initial_signed_armistice
	delta_money = initial_delta_money
	delta_uranium = initial_delta_uranium
	delta_influence = initial_delta_influence
	delta_research_progress = initial_delta_research_progress
	delta_willingness_to_fire_nukes = initial_delta_willingness_to_fire_nukes

func raise_war_taxes() -> void:
	if influence >= 100:
		influence -= 100
		delta_money += 10

#function called for spreading positive propaganda of own country
func spread_propaganda(target):
	if money >= 100:
		money -= 100
		delta_influence[target] += 10

#function called for spreading negative propaganda of target country
func spread_counter_propaganda(target):
	if money >= 100:
		money -= 100
		CountryManager.countries[target].delta_influence[target] -= 10
