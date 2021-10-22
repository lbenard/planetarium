extends Node

var iron_miner: Building = IronMiner.new();

var timer = Timer.new();
var buildings = [];

func _init():
	add_child(timer);
	buildings = [
		iron_miner
	];

func _ready():
	timer.autostart = true;
	timer.connect("timeout", self, "_tick");
	timer.start();

func _tick():
	for building in buildings:
		building.tick();
