extends Resource
class_name Element

var name;
var short;

static func from_name(name: String, short = null):
	var new_element = load("res://resources/element.gd").new();
	new_element.name = name;
	new_element.short = short;
	return new_element;
