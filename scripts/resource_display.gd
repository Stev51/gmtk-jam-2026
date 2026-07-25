extends Control

@onready var money_node = $Money/ResourceCount
@onready var uranium_node = $Uranium/ResourceCount
@onready var nukes_node = $Nukes/ResourceCount

func _process(_delta: float) -> void:
		money_node.text = str(int(Globals.PlayerCountry.money))
		uranium_node.text = str(int(Globals.PlayerCountry.uranium))
		nukes_node.text = str(int(Globals.PlayerCountry.nukes))
