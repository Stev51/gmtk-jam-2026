extends CustomMenuButton

func resource_conditions_met() -> bool:
	if Globals.PlayerCountry.money >= 10000:
		return true
	else:
		return false

func perform_action() -> void:
	Globals.PlayerCountry.send_gift(Globals.selected_country)

func get_description() -> String:
	var text = "Give money in exchange for influence\n"
	text += "Cost: "
	if Globals.PlayerCountry.money >= 10000:
		text += "[color=green]"
	else:
		text += "[color=red]"
	text += "$10,000[/color]\n"
	
	text += "Influence gained: 20"
	return text
