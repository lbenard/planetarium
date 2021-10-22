extends GridContainer

onready var refresh_timer: Timer = $RefreshTimer;
var buildings = {};

var entry_font = preload("res://ui/planet_card/entry_font.tres");

func update_planet(planet: Planet):
	for building in BuildingManager.buildings:
		if planet in (building as Building).stellars_buildings:
			var title = Label.new();
			title.add_font_override("font", entry_font);
			title.text = building.name;
			
			var amount = Label.new();
			amount.text = str((building as Building).stellars_buildings[planet]);
			
			add_child(title);
			add_child(amount);
			
			buildings[building] = amount;


func _on_RefreshTimer_timeout():
	for child in get_children():
		child.queue_free();
		remove_child(child);
