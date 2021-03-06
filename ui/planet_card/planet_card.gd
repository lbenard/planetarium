extends Control
class_name PlanetCard

var planet: Planet = null setget _set_planet;
onready var composition_grid = $Card/VBoxContainer/MarginContainer/Content/ScrollContainer/VBoxContainer/CompositionGrid;
onready var buildings_grid = $Card/VBoxContainer/MarginContainer/Content/ScrollContainer/VBoxContainer/BuildingsGrid;
onready var title_label = $Card/VBoxContainer/Panel/MarginContainer/Title/HBoxContainer/Label;
onready var style = ($Card/VBoxContainer/Panel).get_stylebox("panel");

var separator_font = preload("res://ui/planet_card/separator_font.tres");
var entry_font = preload("res://ui/planet_card/entry_font.tres");

var building_labels = {};

func _init():
	GameEvents.connect("planet_focus", self, "_on_planet_focus");

func add_child(node, _a: bool = false):
	.add_child(node, _a);

func _on_planet_focus(planet: Planet):
	self.planet = planet;

func _set_planet(value: Planet):
	planet = value;
	title_label.text = planet.name;
	style.bg_color = Color.from_hsv(planet.mesh.material_override.albedo_color.h, 100.0 / 255.0, 150.0 / 255.0);
	
	composition_grid.update_planet(planet);
	buildings_grid.update_planet(planet);
	
	#_add_separator_labels("Buildings");
	#_add_building_labels(planet);
	
	#_add_separator_labels("Electricity");
	#_add_electricity_production_labels(planet.electricity_production);
	#_add_electricity_consumption_labels(planet.electricity_consumption);


#func _add_electricity_production_labels(production: float):
#	var title = Label.new();
#	var content = Label.new();
#	
#	title.text = "Production";
#	title.add_font_override("font", entry_font);
#	content.text = "%s W" % int(production);
#	grid_container.add_child(title);
#	grid_container.add_child(content);

#func _add_electricity_consumption_labels(consumption: float):
#	var title = Label.new();
#	var content = Label.new();
#	
#	title.text = "Consumption";
#	title.add_font_override("font", entry_font);
#	content.text = "%s W" % int(consumption);
#	grid_container.add_child(title);
#	grid_container.add_child(content);
