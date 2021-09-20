tool
extends Node

export var galaxies: Array;

class Galaxy:
	var name: String;
	var planetary_systems: Array;

func _ready():
	for child in get_children():
		child.queue_free();
	if Engine.editor_hint:
		var node = Spatial.new();
		add_child(node);
		node.set_owner(get_tree().edited_scene_root);
