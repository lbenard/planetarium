extends Miner
class_name IronMiner

static func _mined_element() -> Element:
	return Elements.standard.iron;


static func can_be_built(stellar: Stellar) -> bool:
	if stellar.elements.keys().find(_mined_element()) != -1:
		return true;
	return false;
