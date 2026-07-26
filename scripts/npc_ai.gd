extends Node

var RWT_weight = 0.0
var SP_weight = 0.0
var BL_weight = 0.0
var BM_weight = 0.0
var ENC_weight = 0.0
var BN_weight = 0.0
var Domestic_Pass_weight = 0.0

var SG_weight = 0.0
var SCP_weight = 0.0
var SD_weight = 0.0
var SOT_weight = 0.0
var SM_weight = 0.0
var SL_weight = 0.0
var SU_weight = 0.0
var CF_weight = 0.0
var Foreign_Pass_weight = 0.0

#Called by CountryManager
func run_npc_ai(country: Country):
	#calculate weight for each action
	#0 if it's unaffordable/impossible, then increasing as it "seems favorable"
	RWT_weight = 1
	SP_weight = 1
	BL_weight = 1
	BM_weight = 1
	ENC_weight = 1
	BN_weight = 1
	Domestic_Pass_weight = 1
	
	var sum_domestic_weight = RWT_weight + SP_weight + BL_weight + BM_weight + ENC_weight + BN_weight + Domestic_Pass_weight
	var weight_target = randf_range(0.0, sum_domestic_weight)
	var weight_partial_sum = RWT_weight
	#choose one of the following based on weights
	if weight_target < weight_partial_sum:
		country.raise_war_taxes()
	else:
		weight_partial_sum += SP_weight
		if weight_target < weight_partial_sum:
			country.spread_propaganda()
		else:
			weight_partial_sum += BL_weight
			if weight_target < weight_partial_sum:
				country.build_lab()
			else:
				weight_partial_sum += BM_weight
				if weight_target < weight_partial_sum:
					country.build_mine()
				else:
					weight_partial_sum += ENC_weight
					if weight_target < weight_partial_sum:
						country.establish_nuclear_capabilities()
					else:
						weight_partial_sum += BN_weight
						if weight_target < weight_partial_sum:
							country.build_nuke()
						else:
							pass
	
	for country_b in CountryManager.countries:
		#calculate weight for each action
		#0 if it's unaffordable/impossible, then increasing as it "seems favorable"
		SG_weight = 1
		SCP_weight = 1
		SD_weight = 1
		SOT_weight = 1
		SM_weight = 1
		SL_weight = 1
		SU_weight = 1
		CF_weight = 1
		Foreign_Pass_weight = 1
		
		var sum_foreign_weight = SG_weight + SCP_weight + SD_weight + SOT_weight + SM_weight + SL_weight + SU_weight + CF_weight + Foreign_Pass_weight
		weight_target = randf_range(0.0, sum_foreign_weight)
		weight_partial_sum = SG_weight
		#choose one of the following based on weights
		if weight_target < weight_partial_sum:
			country.send_gift(country_b)
		else:
			weight_partial_sum += SCP_weight
			if weight_target < weight_partial_sum:
				country.spread_counter_propaganda(country_b)
			else:
				weight_partial_sum += SD_weight
				if weight_target < weight_partial_sum:
					country.send_diplomat(country_b)
				else:
					weight_partial_sum += SOT_weight
					if weight_target < weight_partial_sum:
						country.spy_on_technology(country_b)
					else:
						weight_partial_sum += SM_weight
						if weight_target < weight_partial_sum:
							country.sabotage_mine(country_b)
						else:
							weight_partial_sum += SL_weight
							if weight_target < weight_partial_sum:
								country.sabotage_lab(country_b)
							else:
								weight_partial_sum += SU_weight
								if weight_target < weight_partial_sum:
									country.steal_uranium(country_b)
								else:
									weight_partial_sum += CF_weight
									if weight_target < weight_partial_sum:
										country.calm_fears(country_b)
									else:
										pass
