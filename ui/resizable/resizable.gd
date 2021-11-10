extends WindowDialog
class_name Resizable
tool

export var top_resizable: bool = true;
export var right_resizable: bool = true;
export var bottom_resizable: bool = true;
export var left_resizable: bool = true;
var _scaleborder: int;

func _ready():
	#if not Engine.editor_hint:
	#	call_deferred("popup");
	get_close_button().hide();
	
	# Resize to fit invisible window bounds
	# For some reasons the first child is a TextureButton (probably the close button?)
	#(get_children()[1] as Control).margin_top = -20;
	_scaleborder = get_constant("scaleborder_size") + 2; # Just to be safe


func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position();
	var resizable_rect = get_rect();
	var rect_middle = resizable_rect.position + resizable_rect.size / 2;
	
	resizable = true;
	if mouse_pos.y < resizable_rect.position.y + _scaleborder:
		resizable = resizable && top_resizable;
	if mouse_pos.x > resizable_rect.end.x - _scaleborder:
		resizable = resizable && right_resizable;
	if mouse_pos.y > resizable_rect.end.y - _scaleborder:
		resizable = resizable && bottom_resizable;
	if mouse_pos.x < resizable_rect.position.x + _scaleborder:
		resizable = resizable && left_resizable;
