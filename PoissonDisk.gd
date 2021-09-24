extends Node2D
tool

class Star:
	var pos: Vector2;
	var density: float;

var resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"));
export(OpenSimplexNoise) var noise = OpenSimplexNoise.new() setget _set_noise;
var image = noise.get_image(resolution.x * 2, resolution.y * 2);
onready var noise_sprite = $Noise;
export var start: Vector2 = Vector2.ZERO setget _set_start;
export var gap: int = 10 setget _set_gap;
export var star_count: int = 0 setget _set_star_count;
export var reload: bool = false setget _set_reload;
export var stars = [];

func _ready():
	noise.seed = 42;
	noise.octaves = 2;
	noise.persistence = 0.1;
	noise.lacunarity = 1.5;
	render_noise();

func _process(_delta):
	update();

func _draw():
	resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"));
	for star in stars:
		draw_circle(star.pos, (1.0 - ((star.density + 1.0) / 2.0)) * gap, Color(1.0, 0.0, 0.0, 0.2));
		draw_circle(star.pos, 1.0, Color.red);
		
		draw_line(star.pos - Vector2(gap / 2.0, 0.0), Vector2(star.pos.x + gap / 2.0, star.pos.y - gap / 2.0), Color.red, 1.0, true);
		draw_line(Vector2(star.pos.x + gap / 2.0, star.pos.y - gap / 2.0), Vector2(star.pos.x + gap / 2.0, star.pos.y + gap / 2.0), Color.red, 1.0, true);
		draw_line(Vector2(star.pos.x + gap / 2.0, star.pos.y + gap / 2.0), star.pos - Vector2(gap / 2.0, 0.0), Color.red, 1.0, true);
	
	
	
	#draw_line(start - Vector2(gap / 2.0, 0.0), Vector2(start.x + gap / 2.0, start.y - gap / 2.0), Color.red, 1.0, true);
	#draw_line(Vector2(start.x + gap / 2.0, start.y - gap / 2.0), Vector2(start.x + gap / 2.0, start.y + gap / 2.0), Color.red, 1.0, true);
	#draw_line(Vector2(start.x + gap / 2.0, start.y + gap / 2.0), start - Vector2(gap / 2.0, 0.0), Color.red, 1.0, true);

func add_star(origin = null):
	resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"));
	var new_star = Star.new();

	if origin == null: # Default star position
		new_star.pos = start;
	else:
		new_star.pos = origin.pos + Vector2(gap, 0.0);

	new_star.density = (noise.get_noise_2d(new_star.pos.x, new_star.pos.y) + 1.0) / 2.0;
	stars.push_back(new_star);

func regenerate():
	stars.clear()
	var old_star_count = star_count;
	star_count = 0;
	_set_star_count(old_star_count);

func render_noise():
	var noise_image = Image.new();
	noise_image.create(resolution.x, resolution.y, false, Image.FORMAT_RGB8);
	noise_image.lock();
	for y in resolution.y:
		for x in resolution.x:
			var result = (noise.get_noise_2d(x, y) + 1.0) / 2.0;
			noise_image.set_pixel(x, y, Color(result, result, result));
	var texture = ImageTexture.new();
	texture.create_from_image(noise_image);
	print_debug("render");
	$Noise.texture = texture;

func _set_start(value):
	start = value;
	regenerate();
	update();

func _set_gap(value):
	gap = value;
	regenerate();
	update();

func _set_star_count(value):
	if value < 0:
		star_count = 0;
		return;
	
	if value < star_count: # Remove stars
		while value < star_count:
			stars.pop_back();
			star_count -= 1;
	else: # Add stars
		while value > star_count:
			if star_count == 0: # First star
				add_star();
			else:
				add_star(stars[stars.size() - 1]);
			star_count += 1;
	update();

func _set_reload(_value):
	reload = false
	regenerate()
	update();

func _set_noise(value):
	print_debug("set_noise");
	noise = value;
	render_noise();
	regenerate();
	update();
