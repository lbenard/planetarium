extends GridContainer

class BuildingLabels:
	var title: Label;
	var amount: Label;

# Key: Building
# Value: BuildingLabels
var buildings_labels = {};
var planet;

var entry_font = preload("res://ui/planet_card/entry_font.tres");

func _init():
	GameEvents.connect("building_created", self, "_building_created");
	GameEvents.connect("building_destroyed", self, "_building_destroyed");

func update_planet(planet: Planet):
	self.planet = planet;
	
	# Remove already existing labels
	for building in buildings_labels.keys():
		_remove_building_label(building);
	
	# And add new ones
	for building in BuildingManager.buildings:
		if planet in (building as Building).stellars_buildings:
			_create_building_label(building);
			_update_building_label(building, planet);


func _building_created(building: Building, stellar: Stellar):
	if stellar != self.planet:
		return;
	if not building in buildings_labels:
		_create_building_label(building);
	
	_update_building_label(building, stellar);


func _building_destroyed(building: Building, stellar: Stellar):
	if stellar != self.planet:
		return;
	if not building in buildings_labels:
		_create_building_label(building);
	
	var new_amount = building.stellars_buildings[stellar];
	if new_amount < 1:
		_remove_building_label(building);

func _create_building_label(building: Building):
	var title = Label.new();
	title.add_font_override("font", entry_font);
	title.text = building.name;
	
	var amount = Label.new();
	amount.text = "-";
	
	buildings_labels[building] = BuildingLabels.new();
	buildings_labels[building].title = title;
	buildings_labels[building].amount = amount;
	add_child(title);
	add_child(amount);


func _remove_building_label(building: Building):
	remove_child(buildings_labels[building].title);
	remove_child(buildings_labels[building].amount);
	buildings_labels[building].title.queue_free();
	buildings_labels[building].amount.queue_free();
	buildings_labels.erase(building);


func _update_building_label(building: Building, stellar: Stellar):
	buildings_labels[building].amount.text = str(building.stellars_buildings[stellar]);
