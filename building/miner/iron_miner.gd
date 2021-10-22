extends Miner
class_name IronMiner

static func _mined_element() -> Element:
	return Elements.standard.iron;


static func _produced_item() -> Item:
	return ItemManager.iron_ingot as Item;


static func can_be_built(stellar: Stellar) -> bool:
	if stellar.elements.keys().find(_mined_element()) != -1:
		return true;
	return false;

func _init():
	name = "Iron miner";
