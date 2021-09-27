extends MeshInstance

export var rotation_speed = 45;

func _process(delta):
	rotate_y(deg2rad(rotation_speed) * delta);
