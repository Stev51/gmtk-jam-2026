class_name Country extends Node

var money
var uranium
var nukes
var influence

@export var initial_money = 0
@export var initial_uranium = 0
@export var initial_nukes = 0
@export var initial_influence = 0

func reset_resources():
	money = initial_money
	uranium = initial_uranium
	nukes = initial_nukes
	influence = initial_influence
