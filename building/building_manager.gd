extends Node

var test_building: Building = TestBuilding.new();

var timer = Timer.new();
var buildings = [];

func _init():
	add_child(timer);
	buildings = [
		test_building
	];

func _ready():
	timer.autostart = true;
	timer.connect("timeout", self, "_tick");
	timer.start();

func _tick():
	for building in buildings:
		building.tick();
