extends Stellar
class_name Planet

export(NodePath) var mesh = MeshInstance.new();
export var rotation_speed: float = 1.0;

# Revolution angle between 0 and 1
var revolution = rand_range(-PI, PI);
export var revolution_speed: float = 0.01;
var distance;

const max_planet_radius = 4;

var sun: Stellar;

func init(sun: Stellar, radius: float, distance: float, color: Color):
	self.sun = sun;
	var sphere_mesh = SphereMesh.new();
	sphere_mesh.radius = radius;
	sphere_mesh.height = sphere_mesh.radius * 2;
	mesh.mesh = sphere_mesh;
	
	var material = SpatialMaterial.new();
	material.albedo_color = color;
	mesh.material_override = material;
	
	self.distance = distance;
	translation = Vector3(distance, 0, 0);

func _ready():
	add_child(mesh);

func _process(delta):
	rotate_y(rotation_speed * delta);
	revolution += revolution_speed * delta;
	translation = Vector3(distance, 0, 0).rotated(Vector3(0, 1, 0), revolution);
