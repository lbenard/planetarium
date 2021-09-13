extends Spatial

onready var cube = $Cube;

func _process(delta):
	cube.rotate_y(PI * delta);
