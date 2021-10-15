extends Resource
class_name Item

var name;

static func from_name(name: String):
	var new_item = load("res://item/item.gd").new();
	new_item.name = name;
	return new_item;
