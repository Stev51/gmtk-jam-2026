class_name Country extends Resource

var money
var uranium
var nukes
var influence

@export var long_name = ""
@export var short_name = ""

@export var initial_money = 0.0
@export var initial_uranium = 0.0
@export var initial_nukes = 0.0
@export var initial_influence = 0.0

func init() -> void:
	reset_resources()

func reset_resources() -> void:
	money = initial_money
	uranium = initial_uranium
	nukes = initial_nukes
	influence = initial_influence
