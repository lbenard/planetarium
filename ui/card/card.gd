extends Control
tool

onready var title: Control = $VBoxContainer/Panel/MarginContainer/Control setget _set_title_node;
onready var content: Control = $VBoxContainer/MarginContainer/Control setget _set_content_node;

var _title_set: bool = false;
var _content_set: bool = false;
var _child_error: String = "Card node cannot have more than two custom children";

func _ready():
	assert(get_children().size() <= 3, _child_error);
	for child_idx in get_children().size():
		match child_idx:
			0:
				pass;
			1:
				title = get_child(child_idx);
				_title_set = true;
			2:
				content = get_child(child_idx);
				_content_set = true;
	print_tree_pretty();


func add_child(node, _a: bool = false):
	.add_child(node, _a);
	if not _title_set:
		title = node;
		remove_child(node);
		
	elif not _content_set:
		_content_set = node;
	else:
		assert(false, _child_error);


func _set_title_node(node: Control):
	var parent = title.get_parent();
	parent.remove_child(title);
	title.queue_free();
	title = node;
	parent.add_child(node);
	node.owner = parent;


func _set_content_node(node: Control):
	var parent = content.get_parent();
	parent.remove_child(content);
	content.queue_free();
	content = node;
	parent.add_child(node);
	node.owner = parent;
