extends Panel
class_name PlanetCard

var planet: Planet = null setget _set_planet;
onready var title_label = $VBoxContainer/Panel/MarginContainer/HBoxContainer/Label;
onready var grid_container: GridContainer = $VBoxContainer/MarginContainer/ScrollContainer/GridContainer;
onready var style = ($VBoxContainer/Panel).get_stylebox("panel");

var separator_font = preload("res://ui/planet_card/separator_font.tres");
var entry_font = preload("res://ui/planet_card/entry_font.tres");

func _init():
	GameEvents.connect("planet_focus", self, "_on_planet_focus");

func _on_planet_focus(planet: Planet):
	self.planet = planet;

func _set_planet(value: Planet):
	planet = value;
	title_label.text = planet.name;
	style.bg_color = Color.from_hsv(planet.mesh.material_override.albedo_color.h, 100.0 / 255.0, 150.0 / 255.0);
	for n in grid_container.get_children():
		grid_container.remove_child(n);
		n.queue_free();
	_add_separator("Composition");
	_add_atmosphere(planet.atmosphere);
	_add_elements(planet.elements);
	
	_add_separator("Electricity");
	_add_electricity_production(planet.electricity_production);
	_add_electricity_consumption(planet.electricity_consumption);

func _add_separator(title: String):
	var label = Label.new()
	label.text = title;
	label.add_font_override("font", separator_font);
	if grid_container.get_children().size() != 0:
		grid_container.add_child(HSeparator.new());
		grid_container.add_child(HSeparator.new());
	grid_container.add_child(label);
	grid_container.add_child(Control.new());

func _add_atmosphere(atmosphere: Dictionary):
	var title = Label.new();
	var content = Label.new();
	
	title.text = "Atmosphere";
	title.add_font_override("font", entry_font);
	var names = [];
	for element in atmosphere.keys():
		names.push_back(_get_element_name(element));
	content.text = PoolStringArray(names).join(", ");
	grid_container.add_child(title);
	grid_container.add_child(content);

func _add_elements(elements: Dictionary):
	var title = Label.new();
	var content = Label.new();
	
	title.text = "Elements";
	title.add_font_override("font", entry_font);
	var names = [];
	for element in elements.keys():
		names.push_back(_get_element_name(element));
	content.text = PoolStringArray(names).join(", ");
	grid_container.add_child(title);
	grid_container.add_child(content);

func _get_element_name(element: Element) -> String:
	if element.short:
		return "%s (%s)" % [element.name, element.short];
	else:
		return element.name;

func _add_electricity_production(production: float):
	var title = Label.new();
	var content = Label.new();
	
	title.text = "Production";
	title.add_font_override("font", entry_font);
	content.text = "%s W" % int(production);
	grid_container.add_child(title);
	grid_container.add_child(content);

func _add_electricity_consumption(consumption: float):
	var title = Label.new();
	var content = Label.new();
	
	title.text = "Consumption";
	title.add_font_override("font", entry_font);
	content.text = "%s W" % int(consumption);
	grid_container.add_child(title);
	grid_container.add_child(content);
