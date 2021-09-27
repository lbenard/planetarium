extends StellarManager

export(OpenSimplexNoise) var noise = OpenSimplexNoise.new();
var noise_seed = 0;

func _ready():
	randomize();
	noise_seed = randi();
