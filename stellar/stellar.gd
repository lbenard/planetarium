extends Spatial
class_name Stellar

var procedural_seed: int;

# Element per second
var elements: Dictionary = {};
var item_inventory: Inventory = Inventory.new();
#var electricity_production = 0;
#var electricity_consumption = 0;

func _init():
	item_inventory.init(16, 1000);
