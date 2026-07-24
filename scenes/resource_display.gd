extends Control

@onready var money_node = $Money/ResourceCount
@onready var uranium_node = $Uranium/ResourceCount
@onready var nukes_node = $Nukes/ResourceCount

var PlayerCountry

func _ready() -> void:
	# Fetch the root of the active scene and check if it's already done
	var current_scene = get_tree().current_scene
	if current_scene.is_node_ready():
		_on_entire_tree_ready()
	else:
		current_scene.ready.connect(_on_entire_tree_ready)
func _on_entire_tree_ready() -> void:
	PlayerCountry = CountryManager.countries[0]

func _process(_delta: float) -> void:
		money_node.text = str(int(PlayerCountry.money))
		uranium_node.text = str(int(PlayerCountry.uranium))
		nukes_node.text = str(int(PlayerCountry.nukes))
