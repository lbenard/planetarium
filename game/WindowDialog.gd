extends WindowDialog

func _ready():
	call_deferred("popup");
	get_close_button().hide();
