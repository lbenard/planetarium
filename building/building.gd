extends Resource
class_name Building

# Stellars on which the building is built
# Key: Stellar
# Value: Amount
var stellars_buildings: Dictionary = {};
var name: String;

static func can_be_built(_stellar: Stellar) -> bool:
	return false


func build_on(stellar: Stellar):
	if not stellar in stellars_buildings:
		stellars_buildings[stellar] = 0;
	stellars_buildings[stellar] += 1;


func tick():
	pass
