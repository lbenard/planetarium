extends Node

export(OpenSimplexNoise) var noise = OpenSimplexNoise.new();
var stars = {};

func _init():
	noise.seed = 0;

func _ready():
	get_star(Vector2.ZERO);

func get_star(pos: Vector2):
	if pos in stars:
		return stars[pos];
	else:
		stars[pos] = 
