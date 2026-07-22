class_name Country extends Node

# value is index in the resources array
enum ResourceType {MONEY=0, URANIUM=1, NUKES=2, INFLUENCE=3}
var resources = [0, 0, 0, 0]

func set_resource(resource: ResourceType, new_value):
	resources[resource] = new_value

func edit_resource(resource: ResourceType, delta):
	resources[resource] = resources[resource] + delta
