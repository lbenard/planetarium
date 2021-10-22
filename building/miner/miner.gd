extends Building
class_name Miner

var storage: int = 0;
var storage_capacity = 1000;

static func _mined_element() -> Element:
	return null;


static func _produced_item() -> Item:
	return null;


func tick():
	for stellar in stellars_buildings:
		(stellar as Stellar).item_inventory.add(_produced_item(), 1);
