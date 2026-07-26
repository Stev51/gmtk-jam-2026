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

@export var war_taxes_influence_cost = 10
@export var war_taxes_delta_money_gain = 1
@export var spread_propaganda_cost = 3000
@export var spread_progaganda_delta_influence_gain = 0.1
@export var build_lab_cost = 5000
@export var build_mine_cost = 5000
@export var nuke_cost = 10000
@export var gift_cost = 5000
@export var gift_influence_gain = 10
@export var spread_counter_propaganda_cost = 5000
@export var spread_counter_propaganda_delta_influence_enemy_loss = 0.1
@export var send_diplomat_influence_cost = 10
@export var send_diplomat_delta_influence_gain = 0.1
@export var spy_on_technology_cost = 5000
@export var sabotage_mine_cost = 5000
@export var sabotage_mine_influence_cost = 30
@export var sabotage_lab_cost = 5000
@export var sabotage_lab_influence_cost = 30
@export var steal_uranium_cost = 5000
@export var steal_uranium_influence_cost = 30
@export var steal_uranium_uranium_gain = 0.5
@export var calm_fears_influence_cost = 20
@export var calm_fears_willingness_decrease = 20
@export var convince_to_sign_influence_cost = 80

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
	if influence[index] >= war_taxes_influence_cost:
		influence[index] -= war_taxes_influence_cost
		delta_money += war_taxes_delta_money_gain

#function called for spreading positive propaganda of own country
func spread_propaganda() -> void:
	if money >= spread_propaganda_cost:
		money -= spread_propaganda_cost
		delta_influence[index] += spread_progaganda_delta_influence_gain

func build_lab() -> void:
	if money >= build_lab_cost:
		money -= build_lab_cost
		labs += 1

func build_mine() -> void:
	if money >= build_mine_cost:
		money -= build_mine_cost
		mines += 1

func establish_nuclear_capabilities() -> void:
	if research_progress > 99.9:
		can_build_nukes = true

func build_nuke() -> void:
	if money >= nuke_cost && uranium > 1 && can_build_nukes == true:
		money -= nuke_cost
		uranium -= 1
		nukes += 1

#Only available to the player
func enforce_armistice() -> void:
	if CountryManager.all_countries_signed_armistice == true:
		DoomsdayClock.infinite_hour.emit()

#Foreign Actions

func send_gift(target: Country) -> void:
	if money >= gift_cost:
		money -= gift_cost
		influence[target.index] += gift_influence_gain

#function called for spreading negative propaganda of target country
func spread_counter_propaganda(target: Country) -> void:
	if money >= spread_counter_propaganda_cost:
		money -= spread_counter_propaganda_cost
		target.delta_influence[target.index] -= spread_counter_propaganda_delta_influence_enemy_loss

func send_diplomat(target: Country) -> void:
	if influence[index] > send_diplomat_influence_cost:
		influence[index] -= send_diplomat_influence_cost
		delta_influence[target.index] += send_diplomat_delta_influence_gain

func spy_on_technology(target: Country) -> void:
	if money >= spy_on_technology_cost:
		money -= spy_on_technology_cost
		#Boost progress by half the tech gap, at least 5
		research_progress += maxf(5, (target.research_progress - research_progress) / 2)

func sabotage_mine(target: Country) -> void:
	if money >= sabotage_mine_cost && influence[target.index] >= sabotage_mine_influence_cost && target.mines >= 1:
		money -= sabotage_mine_cost
		influence[target.index] -= sabotage_mine_influence_cost
		target.mines -= 1

func sabotage_lab(target: Country) -> void:
	if money >= sabotage_lab_cost && influence[target.index] >= sabotage_lab_influence_cost && target.labs >= 1:
		money -= sabotage_lab_cost
		influence[target.index] -= sabotage_lab_influence_cost
		target.labs -= 1

func steal_uranium(target: Country) -> void:
	if money >= steal_uranium_cost && influence[target.index] >= steal_uranium_influence_cost && target.uranium >= steal_uranium_uranium_gain:
		money -= steal_uranium_cost
		influence[target.index] -= steal_uranium_influence_cost
		target.uranium -= steal_uranium_uranium_gain
		uranium += steal_uranium_uranium_gain

func calm_fears(target: Country):
	if influence[target.index] >= calm_fears_influence_cost && target.willingness_to_fire_nukes >= calm_fears_willingness_decrease:
		influence[target.index] -= calm_fears_influence_cost
		target.willingness_to_fire_nukes -= calm_fears_willingness_decrease

#Only available to the player
func convince_to_sign_armistice(target: Country) -> void:
	if influence[target.index] >= convince_to_sign_influence_cost && target.willingness_to_fire_nukes <= 10 && target.signed_armistice == false:
		influence[target.index] -= convince_to_sign_influence_cost
		target.willingness_to_fire_nukes -=10
		target.signed_armistice = true
