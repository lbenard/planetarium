extends Node2D
tool

var resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"));
export(OpenSimplexNoise) var noise = OpenSimplexNoise.new() setget _set_noise;
var rng = RandomNumberGenerator.new();
var noise_texture = null;
var noise_sprite = null;
export var reload: bool = false setget _set_reload;
export var chunk_length: int = 16 setget _set_chunk_length;
export var generation_radius: int = 1 setget _set_generation_radius;

## Chunks
class Chunk:
	var stellar = null;
	var stellar_relative_pos: Vector2 = Vector2.ZERO;
	var subdivision_flip: bool = false;

# Key: Vector2 (multiples of 1)
# Value: Chunk
export var chunks: Dictionary = {};

func _ready():
	noise.seed = 3;
	noise.octaves = 20;
	noise.persistence = 0.1;
	noise.lacunarity = 1.5;
	noise_sprite = $Noise;
	if noise_texture == null:
		render_noise();
	noise_sprite.texture = noise_texture;

func _process(_delta):
	update();

func _draw():
	for coordinate in chunks:
		var rect = Rect2(coordinate * chunk_length, Vector2.ONE * chunk_length);
		#draw_rect(rect, Color(1.0, 0.0, 0.0, 0.1), true, 1.0, false);
		#draw_rect(rect, Color.red, false, 1.0, true);
		var chunk = chunks[coordinate];
		#if chunk.subdivision_flip:
		#	draw_line(rect.position, rect.end, Color.red, 1.0, true);
		#else:
		#	draw_line(Vector2(rect.end.x, rect.position.y), Vector2(rect.position.x, rect.end.y), Color.red, 1.0, true);
		
		#print_debug(chunks);
		if chunk.stellar != null:
			draw_circle(rect.position + chunk.stellar_relative_pos * chunk_length, chunk_length / 10.0, Color.red);

func regenerate():
	for x in generation_radius:
		for y in generation_radius:
			var coordinates = Vector2(x, y);
			chunks[coordinates] = generate_chunk(coordinates);

func generate_chunk(coordinates):
	var chunk = Chunk.new();
	chunk.subdivision_flip = (int(coordinates.x) + int(coordinates.y) % 2) % 2 == 0
	
	var real_coordinate = coordinates * chunk_length;
	var density = noise_2d(real_coordinate);
	var base_seed = str(real_coordinate.x) + "/" + str(real_coordinate.y);
	rng.seed = base_seed.hash();
	if rng.randf() < density:
		chunk.stellar = 1;
		rng.seed = (base_seed + "x").hash();
		chunk.stellar_relative_pos.x = rng.randf_range(0.1, 0.9);
		rng.seed = (base_seed + "y").hash();
		chunk.stellar_relative_pos.y = rng.randf_range(0.1, 0.9);
	return chunk;

func render_noise():
	var noise_image = Image.new();
	noise_image.create(resolution.x, resolution.y, false, Image.FORMAT_RGB8);
	noise_image.lock();
	for y in resolution.y:
		for x in resolution.x:
			var result = noise_2d(Vector2(x, y));
			noise_image.set_pixel(x, y, Color(result, result, result));
	var texture = ImageTexture.new();
	texture.create_from_image(noise_image);
	noise_texture = texture;

func noise_2d(pos: Vector2) -> float:
	return clamp((noise.get_noise_2d(pos.x, pos.y) + 1.0) / 2.0 - 0.3, 0.0, 1.0);

func _set_noise(value):
	noise = value;
	render_noise();
	regenerate();
	update();

func _set_reload(_value):
	reload = false
	chunks = {};
	regenerate()
	update();

func _set_chunk_length(value):
	chunk_length = value;
	regenerate();
	update();

func _set_generation_radius(value):
	generation_radius = value;
	regenerate();
	update();
