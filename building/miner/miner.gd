extends Building
class_name Miner

var storage: int = 0;
var storage_capacity = 1000;

func _ready():
	pass

static func _mined_element() -> Element:
	return null;

func tick():
	for stellar in stellars_buildings.keys():
		#if stellar.storages.has_room
		pass
