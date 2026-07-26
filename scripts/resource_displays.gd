extends Control

@onready var money_node = $GridContainer/Money
@onready var uranium_node = $GridContainer/Uranium
@onready var nukes_node = $GridContainer/Nukes
@onready var research_node = $GridContainer/Research
@onready var labs_node = $GridContainer/Labs
@onready var mines_node = $GridContainer/Mines
@onready var influence_node = $GridContainer/Influence

func _process(_delta: float) -> void:
		money_node.set_text("$" + str(int(Globals.PlayerCountry.money)))
		uranium_node.set_text(str(int(Globals.PlayerCountry.uranium)))
		nukes_node.set_text(str(int(Globals.PlayerCountry.nukes)))
		research_node.set_text(str(int(Globals.PlayerCountry.research_progress)))
		labs_node.set_text(str(int(Globals.PlayerCountry.labs)))
		mines_node.set_text(str(int(Globals.PlayerCountry.mines)))
		influence_node.set_text(str(Globals.PlayerCountry.influence[Globals.PlayerCountry.index]))
