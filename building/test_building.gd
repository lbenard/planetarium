extends Building
class_name TestBuilding

static func can_be_built(_stellar: Stellar) -> bool:
	return true;


func tick():
	for stellar in stellars_buildings.keys():
		stellar.electricity_production = 20;
